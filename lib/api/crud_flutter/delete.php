<?php

$conn = new mysqli("localhost", "root", "", "upn_mahasiswa");

$nim = $_POST["nim"];
$data = mysqli_query($conn, "DELETE FROM mahasiswa WHERE nim='$nim' ");

if ($data) {
    echo json_encode([
        'pesan' => 'Sukses!']);
} else {
    echo json_encode([
        'pesan' => 'Gagal!']);
}

?>