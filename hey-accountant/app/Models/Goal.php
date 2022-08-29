<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Goal extends Model
{
    use HasFactory;
    // If db table is named differently than the model
    // protected $table = 'my_table';
    
    // specify the list of fields
    protected $fillable = [
        'name',
        'description',
        'amount'
    ];
}
