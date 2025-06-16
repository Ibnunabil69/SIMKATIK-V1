<?php

namespace Database\Seeders;

use App\Enums\UserRole;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run()
    {
        User::updateOrCreate([
            'email' => 'admin@test.mail'
        ], [
            'nama_lengkap' => 'Admin',
            'username' => 'admin',
            'password' => Hash::make('12345678'),
            'role' => UserRole::Admin->value,
            'profile_picture' => 'default.jpg'
        ]);

        User::updateOrCreate([
            'email' => 'karyawan@test.mail'
        ], [
            'nama_lengkap' => 'Karyawan',
            'username' => 'karyawan',
            'password' => Hash::make('12345678'),
            'role' => UserRole::Karyawan->value,
            'profile_picture' => 'default.jpg'
        ]);
    }
}
