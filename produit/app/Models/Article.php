<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Article extends Model
{
    use HasFactory;
    
    protected $fillable = [
        'nom',
        'description',
        'prix',
        'quantite',
        'image'
    ];
    
    // Relation avec les catégories
    public function categories()
    {
        return $this->belongsToMany(Category::class);
    }
}
