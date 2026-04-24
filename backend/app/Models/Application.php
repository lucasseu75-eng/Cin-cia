<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Application extends Model
{
    use HasFactory;

    protected $fillable = [
        'actor_id',
        'casting_id',
        'status',
        'result_status',
        'agent_message',
        'result_published_at',
    ];

    protected function casts(): array
    {
        return [
            'result_published_at' => 'datetime',
        ];
    }

    public function actor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'actor_id');
    }

    public function casting(): BelongsTo
    {
        return $this->belongsTo(Casting::class);
    }
}
