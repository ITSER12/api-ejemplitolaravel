<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Usuario extends Model
{
    //Referencia tabla usuario
    protected $table = 'usuarios';
    //Hacer los cambios sean editables
    protected $fillable = [
        'nombre',
        'apaterno',
        'amaterno',
        'email',
        'password',
        'telefono',
        'activo',
    ];
    
    public function roles()
    {
        return $this->belongsToMany(Rol::class, 'usuario_rol', 'usuario_id', 'rol_id');
    }
}
