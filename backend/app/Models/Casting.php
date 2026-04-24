<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Casting extends Model
{
    use HasFactory;

    protected $fillable = [
        'agent_id',
        'title',
        'description',
        'type',
        'casting_mode',
        'casting_date',
        'default_duration',
        'is_published',
        'location',
        'image_url',
        'rating',
        'reviews_count_text',
        'is_urgent',
        'tags',
    ];

    protected function casts(): array
    {
        return [
            'is_urgent' => 'boolean',
            'is_published' => 'boolean',
            'casting_date' => 'date',
            'default_duration' => 'integer',
            'tags' => 'array',
        ];
    }

    public function agent(): BelongsTo
    {
        return $this->belongsTo(User::class, 'agent_id');
    }

    public function applications(): HasMany
    {
        return $this->hasMany(Application::class);
    }

    public function auditions(): HasMany
    {
        return $this->hasMany(Audition::class);
    }
}
