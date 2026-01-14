<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OderItem extends Model
{
    use HasFactory;

    // ✅ Your real table name in DB
    protected $table = 'oder_items';

    // ✅ Allow mass assignment (optional but recommended)
    protected $fillable = [
        'product_id',
        'order_id',
        'price',
        'quantity',
    ];

    public function order()
    {
        return $this->belongsTo(Order::class);
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}
