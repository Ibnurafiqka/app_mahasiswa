<?php

$conn = new mysqli("localhost", "root", "", "upn_mahasiswa");
$nim = $_POST["nim"];
$nama = $_POST["nama"];
$prodi = $_POST["prodi"];
$alamat = $_POST["alamat"];
$data = mysqli_query($conn, "INSERT INTO mahasiswa set nim='$nim', nama='$nama', prodi='$prodi', alamat='$alamat' ");

if ($data) {
    echo json_encode([
        'pesan' => 'Sukses!']);
} else {
    echo json_encode([
        'pesan' => 'Gagal!']);
}

?>