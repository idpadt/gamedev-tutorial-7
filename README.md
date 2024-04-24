## Latihan Mandiri

### 3d vs 2d?
Berdasarkan tutorial, perbedaan 3d dan 2d tidak terlalu jauh. Yang mungkin paling sulit adalah memahami kode yang menangani rotasi kamera menggunakan mouse. Oleh karena itu, sejauh ini transisi dari 2d ke 3d tidak terlalu sulit.

### Sprinting
Cukup mudah. Selama player menahan tombol SHIFT, speed diubah menjadi run speed. Saat dilepas, kembali ke normal speed

### Crouching
Tidak terlalu sulit karena prosesnya tidak jauh dengan crouching di 2d. Selama player menahan tombol CTRL,  mesh diubah menjadi crouching mesh (ditambah translation agar saat crouch lgsg pendek), collision shape diubah menjadi crouching c.shape (ditambah translation), dan speed diubah menjadi crouching speed. Saat dilepas, semuanya diubah kembali seperti semula.
