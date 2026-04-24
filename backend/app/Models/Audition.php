<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Audition extends Model
{
    use HasFactory;

    protected $fillable = [
        'casting_id',
        'actor_id',
        'application_id',
        'scheduled_at',
        'order_in_queue',
        'status',
        'agent_notes',
        'evaluation_tag',
        'is_shortlisted',
    ];

    protected function casts(): array
    {
        return [
            'scheduled_at' => 'datetime',
            'is_shortlisted' => 'boolean',
        ];
    }

    public function casting(): BelongsTo
    {
        return $this->belongsTo(Casting::class);
    }

    public function actor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'actor_id');
    }

    public function application(): BelongsTo
    {
        return $this->belongsTo(Application::class);
    }
}
