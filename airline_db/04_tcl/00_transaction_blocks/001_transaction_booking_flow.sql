-- ============================================================
-- TCL – Full booking purchase flow with SAVEPOINTs
-- Covers: reservation → passenger → sale → ticket → payment
-- ============================================================

BEGIN;

  SAVEPOINT sp_reservation;

  -- 1. Create reservation
  INSERT INTO commercial.reservation (
      booked_by_customer_id,
      reservation_status_id,
      sale_channel_id,
      reservation_code,
      booked_at
  )
  VALUES (
      '00000000-0000-0000-0000-000000000001', -- customer_id
      '00000000-0000-0000-0000-000000000002', -- status CONFIRMED
      '00000000-0000-0000-0000-000000000003', -- WEB channel
      'BOOK-2025-001',
      now()
  );

  SAVEPOINT sp_passenger;

  -- 2. Add passenger to reservation
  INSERT INTO commercial.reservation_passenger (
      reservation_id,
      person_id,
      passenger_sequence_no,
      passenger_type
  )
  VALUES (
      (SELECT reservation_id FROM commercial.reservation WHERE reservation_code = 'BOOK-2025-001'),
      '00000000-0000-0000-0000-000000000004', -- person_id
      1,
      'ADULT'
  );

  SAVEPOINT sp_sale;

  -- 3. Create sale linked to reservation
  INSERT INTO commercial.sale (
      reservation_id,
      currency_id,
      sale_code,
      sold_at
  )
  VALUES (
      (SELECT reservation_id FROM commercial.reservation WHERE reservation_code = 'BOOK-2025-001'),
      '00000000-0000-0000-0000-000000000005', -- USD currency
      'SALE-2025-001',
      now()
  );

  SAVEPOINT sp_ticket;

  -- 4. Issue ticket
  INSERT INTO commercial.ticket (
      sale_id,
      reservation_passenger_id,
      fare_id,
      ticket_status_id,
      ticket_number,
      issued_at
  )
  VALUES (
      (SELECT sale_id FROM commercial.sale WHERE sale_code = 'SALE-2025-001'),
      (SELECT reservation_passenger_id
         FROM commercial.reservation_passenger rp
         JOIN commercial.reservation r USING (reservation_id)
        WHERE r.reservation_code = 'BOOK-2025-001' AND rp.passenger_sequence_no = 1),
      '00000000-0000-0000-0000-000000000006', -- fare_id
      '00000000-0000-0000-0000-000000000007', -- ISSUED status
      'TKT-0000001',
      now()
  );

  SAVEPOINT sp_payment;

  -- 5. Register payment (use ROLLBACK TO SAVEPOINT sp_payment if gateway fails)
  INSERT INTO payment.payment (
      sale_id,
      payment_status_id,
      payment_method_id,
      currency_id,
      payment_reference,
      amount,
      authorized_at
  )
  VALUES (
      (SELECT sale_id FROM commercial.sale WHERE sale_code = 'SALE-2025-001'),
      '00000000-0000-0000-0000-000000000008', -- CAPTURED
      '00000000-0000-0000-0000-000000000009', -- CREDIT_CARD
      '00000000-0000-0000-0000-000000000005', -- USD
      'PAY-REF-2025-001',
      350.00,
      now()
  );

COMMIT;
