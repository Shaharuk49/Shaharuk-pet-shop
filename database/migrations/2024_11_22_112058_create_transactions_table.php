<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('transactions', function (Blueprint $table) {
            $table->id();

            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('order_id')->constrained()->cascadeOnDelete();

            // Added: sslcommerz + keep your existing modes
           // $table->enum('mode', ['cod', 'card', 'paypal', 'sslcommerz']);



            $table->enum('status', ['pending', 'approved', 'declined', 'refunded'])
                ->default('pending');

            // Added: helpful fields for SSLCommerz tracking/validation
            $table->string('tran_id', 100)->nullable()->index();
            $table->string('val_id', 100)->nullable()->index();
            $table->string('bank_tran_id', 100)->nullable()->index();

            // Optional: store gateway response (debugging / audit)
            $table->json('gateway_response')->nullable();

            $table->timestamps();

            // Optional: enforce unique tran_id (recommended)
            $table->unique('tran_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transactions');
    }
};
