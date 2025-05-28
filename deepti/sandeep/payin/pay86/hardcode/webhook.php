<?php
// http://localhost/gw/payin/pay86/hardcode/webhook.php

$pg_payload='eyJpZCI6ImQ2ZmMzYzFmZTg2MjQ1MmE5NmFmMTI5ODcwNjBhNmE5IiwiY3JlYXRlX3RpbWUiOiIyMDI0LTAxLTA0VDA5OjE4OjA5WiIsInJlc291cmNlX3R5cGUiOiJQQVlNRU5UIiwia2luZCI6IlBBWU1FTlQuQVVUSE9SSVpBVElPTi5DUkVBVEVEIiwicmVzb3VyY2UiOnsiaWQiOiJRMkpLWTlGM0lLUkszN0MwNVVIVyIsInJlZmVyZW5jZV9pZCI6IlEySktZOUYzSUtSSzM3QzA1VUhXIiwiaW52b2ljZV9udW1iZXIiOiI4NjEzODU1MyIsInN0YXRlIjoiYXV0aG9yaXNlZCIsInJlc3VsdCI6eyJhdXRob3Jpc2F0aW9uX2NvZGUiOiIwMDAwMCIsImFkZGl0aW9uYWxfZGF0YSI6eyJkZXNjcmlwdG9yIjpudWxsfSwiY29kZSI6IjAwMDAiLCJkZXNjcmlwdGlvbiI6IkFwcHJvdmVkIn0sInBheWVyX2lkIjoiYzI4N2E4YWYtYzRhNy00ZWZhLWExODctNTc5NjQzZmJjNmJlIiwiY3JlZGl0X2NhcmRfaWQiOiJhYmI1NTk0NC1hMWIyLTRiYmQtYjQ3MC1hNjQ5ZGU1YTQwODciLCJhbW91bnQiOnsiY3VycmVuY3kiOiJVU0QiLCJ0b3RhbCI6IjI1MSJ9LCJyaXNrX2NoZWNrIjp0cnVlLCJjcmVhdGVfdGltZSI6IjIwMjQtMDEtMDRUMDk6MTc6NTNaIn19';
$res=base64_decode($pg_payload);

print_r($res);

/*
_POST: {"pg_signature":"d631ffb5cc69d022e6a0758ae1bb84a34ab7f4c0|ddfd0278f1dfd6faca0d05aa61e5850d89871e71","pg_payload":"eyJpZCI6ImQ2ZmMzYzFmZTg2MjQ1MmE5NmFmMTI5ODcwNjBhNmE5IiwiY3JlYXRlX3RpbWUiOiIyMDI0LTAxLTA0VDA5OjE4OjA5WiIsInJlc291cmNlX3R5cGUiOiJQQVlNRU5UIiwia2luZCI6IlBBWU1FTlQuQVVUSE9SSVpBVElPTi5DUkVBVEVEIiwicmVzb3VyY2UiOnsiaWQiOiJRMkpLWTlGM0lLUkszN0MwNVVIVyIsInJlZmVyZW5jZV9pZCI6IlEySktZOUYzSUtSSzM3QzA1VUhXIiwiaW52b2ljZV9udW1iZXIiOiI4NjEzODU1MyIsInN0YXRlIjoiYXV0aG9yaXNlZCIsInJlc3VsdCI6eyJhdXRob3Jpc2F0aW9uX2NvZGUiOiIwMDAwMCIsImFkZGl0aW9uYWxfZGF0YSI6eyJkZXNjcmlwdG9yIjpudWxsfSwiY29kZSI6IjAwMDAiLCJkZXNjcmlwdGlvbiI6IkFwcHJvdmVkIn0sInBheWVyX2lkIjoiYzI4N2E4YWYtYzRhNy00ZWZhLWExODctNTc5NjQzZmJjNmJlIiwiY3JlZGl0X2NhcmRfaWQiOiJhYmI1NTk0NC1hMWIyLTRiYmQtYjQ3MC1hNjQ5ZGU1YTQwODciLCJhbW91bnQiOnsiY3VycmVuY3kiOiJVU0QiLCJ0b3RhbCI6IjI1MSJ9LCJyaXNrX2NoZWNrIjp0cnVlLCJjcmVhdGVfdGltZSI6IjIwMjQtMDEtMDRUMDk6MTc6NTNaIn19"}


{
    "id": "d6fc3c1fe862452a96af12987060a6a9",
    "create_time": "2024-01-04T09:18:09Z",
    "resource_type": "PAYMENT",
    "kind": "PAYMENT.AUTHORIZATION.CREATED",
    "resource": {
        "id": "Q2JKY9F3IKRK37C05UHW",
        "reference_id": "Q2JKY9F3IKRK37C05UHW",
        "invoice_number": "86138553",
        "state": "authorised",
        "result": {
            "authorisation_code": "00000",
            "additional_data": {
                "descriptor": null
            },
            "code": "0000",
            "description": "Approved"
        },
        "payer_id": "c287a8af-c4a7-4efa-a187-579643fbc6be",
        "credit_card_id": "abb55944-a1b2-4bbd-b470-a649de5a4087",
        "amount": {
            "currency": "USD",
            "total": "251"
        },
        "risk_check": true,
        "create_time": "2024-01-04T09:17:53Z"
    }
}


*/


?>