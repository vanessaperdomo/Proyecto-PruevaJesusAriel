-- ============================================================
-- TCL – Manual recovery: reverse an erroneous invoice
-- Use when an invoice was committed with wrong amounts.
-- Replace UUIDs before running.
-- ============================================================

BEGIN;

  -- 1. Cancel invoice lines
  UPDATE billing.invoice_line
  SET line_description = '[CANCELLED] ' || line_description,
      updated_at       = now()
  WHERE invoice_id = '00000000-0000-0000-0000-000000000000'; -- replace with real invoice_id

  -- 2. Mark invoice as cancelled
  UPDATE billing.invoice
  SET invoice_status_id = (
          SELECT invoice_status_id FROM billing.invoice_status WHERE status_code = 'CANCELLED'
      ),
      notes      = COALESCE(notes || ' | ', '') || 'Manual recovery: overbilled. Cancelled at ' || now()::text,
      updated_at = now()
  WHERE invoice_id = '00000000-0000-0000-0000-000000000000';

  -- 3. Request refund for associated payment
  INSERT INTO payment.refund (
      payment_id,
      refund_reference,
      amount,
      requested_at,
      refund_reason
  )
  SELECT
      p.payment_id,
      'REFUND-MANUAL-' || to_char(now(), 'YYYYMMDD-HH24MISS'),
      p.amount,
      now(),
      'Manual recovery: overbilling on invoice ' || i.invoice_number
  FROM billing.invoice i
  JOIN commercial.sale s USING (sale_id)
  JOIN payment.payment p USING (sale_id)
  WHERE i.invoice_id = '00000000-0000-0000-0000-000000000000'
  LIMIT 1;

COMMIT;
