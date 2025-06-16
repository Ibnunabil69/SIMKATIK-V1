<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/transaction-report', function () {
    return view('pdf.transaction-report');
});
