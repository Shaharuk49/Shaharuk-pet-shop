<?php

return [
    'sandbox' => env('SSLCOMMERZ_SANDBOX', true),

    'store_id' => env('SSLCOMMERZ_STORE_ID'),
    'store_password' => env('SSLCOMMERZ_STORE_PASSWORD'),

    // Official endpoints (v3 session create) :contentReference[oaicite:2]{index=2}
    'session_url_sandbox' => 'https://sandbox.sslcommerz.com/gwprocess/v3/api.php',
    'session_url_live'    => 'https://securepay.sslcommerz.com/gwprocess/v3/api.php', // :contentReference[oaicite:3]{index=3}

    // Validator API endpoints :contentReference[oaicite:4]{index=4}
    'validation_url_sandbox' => 'https://sandbox.sslcommerz.com/validator/api/validationserverAPI.php',
    'validation_url_live'    => 'https://securepay.sslcommerz.com/validator/api/validationserverAPI.php',
];
