<?php
require_once "koneksi.php";

class Mahasiswa 
{
    // Method untuk menampilkan data mahasiswa berdasarkan ID
    public function get_mahasiswabyid($id) {
        global $mysqli;
        
        $query = "SELECT * FROM mahasiswa WHERE id = ?";
        $stmt = $mysqli->prepare($query);
        if ($stmt) {
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            $data = $result->fetch_object();
            
            if ($data) {
                $response = array(
                    'status' => 1,
                    'message' => 'Get Mahasiswa Successfully.',
                    'data' => $data
                );
            } else {
                $response = array(
                    'status' => 0,
                    'message' => 'Data Mahasiswa Not Found.'
                );
            }
            $stmt->close();
        } else {
            $response = array(
                'status' => 0,
                'message' => 'Query preparation failed: ' . $mysqli->error
            );
        }

        header('Content-Type: application/json');
        echo json_encode($response);
    }

    // Method untuk menampilkan data mahasiswa berdasarkan prodi atau menampilkan daftar prodi
    public function get_datamahasiswa($prodi = '') {
        global $mysqli;
        
        if (!empty($prodi)) {
            // Query untuk mencari mahasiswa berdasarkan nama prodi
            $query = "SELECT m.* 
                     FROM mahasiswa m
                     WHERE m.prodi LIKE ?";
            
            $stmt = $mysqli->prepare($query);
            if ($stmt) {
                // Gunakan wildcard untuk pencarian lebih fleksibel
                $search_prodi = "%$prodi%";
                $stmt->bind_param("s", $search_prodi);
                $stmt->execute();
                $result = $stmt->get_result();
                
                $data = array();
                while ($row = $result->fetch_object()) {
                    $data[] = $row;
                }
                
                $response = array(
                    'status' => 1,
                    'message' => 'Get Mahasiswa Successfully.',
                    'data' => $data
                );
                
                $stmt->close();
            } else {
                $response = array(
                    'status' => 0,
                    'message' => 'Query preparation failed',
                    'error' => $mysqli->error
                );
            }
        } else {
            // Jika tidak ada prodi yang dipilih, tampilkan daftar prodi yang tersedia
            $query = "SELECT DISTINCT prodi FROM mahasiswa ORDER BY prodi";
            $result = $mysqli->query($query);
            
            $data = array();
            while ($row = mysqli_fetch_object($result)) {
                $data[] = $row;
            }
            
            $response = array(
                'status' => 1,
                'message' => 'Get Prodi List Successfully.',
                'data' => $data
            );
        }

        header('Content-Type: application/json');
        echo json_encode($response);
    }

    // Method untuk mendapatkan daftar prodi
    public function get_prodilist() {
        global $mysqli;
        
        $query = "SELECT DISTINCT prodi FROM mahasiswa ORDER BY prodi";
        $result = $mysqli->query($query);
        
        $data = array();
        while ($row = mysqli_fetch_object($result)) {
            $data[] = $row;
        }
        
        $response = array(
            'status' => 1,
            'message' => 'Get Prodi List Successfully.',
            'data' => $data
        );

        header('Content-Type: application/json');
        echo json_encode($response);
    }

    // Method untuk menampilkan semua data mahasiswa
    public function get_allmahasiswa() {
        global $mysqli;
        $query = "SELECT id, nim, nama, prodi, alamat FROM mahasiswa";
        
        $data = array();
        $result = $mysqli->query($query);

        while ($row = mysqli_fetch_object($result)) {
            $data[] = $row;
        }

        $response = array(
            'status' => 1,
            'message' => 'Get All List Mahasiswa Successfully.',
            'data' => $data
        );

        header('Content-Type: application/json');
        echo json_encode($response);
    }

    // Method untuk menambah data mahasiswa
    public function insert_mahasiswa() {
        global $mysqli;
        $arrcheckpost = array('nim' => '', 'nama' => '', 'prodi' => '', 'alamat' => '');

        $hitung = count(array_intersect_key($_POST, $arrcheckpost));
        if ($hitung == count($arrcheckpost)) {
            $stmt = $mysqli->prepare("INSERT INTO mahasiswa(nim, nama, prodi, alamat) VALUES (?, ?, ?, ?)");
            $stmt->bind_param("ssss", $_POST['nim'], $_POST['nama'], $_POST['prodi'], $_POST['alamat']);
            
            if ($stmt->execute()) {
                $response = array(
                    'status' => 1,
                    'message' => 'Data Mahasiswa Added Successfully.'
                );
            } else {
                $response = array(
                    'status' => 0,
                    'message' => 'Data Mahasiswa Addition Failed: ' . $stmt->error
                );
            }

            $stmt->close();
        } else {
            $response = array(
                'status' => 0,
                'message' => 'Parameter Do Not Match'
            );
        }

        header('Content-Type: application/json');
        echo json_encode($response);
    }

    // Method untuk mengupdate data mahasiswa
    public function update_mahasiswa($id) {
        global $mysqli;
        $arrcheckpost = array('nim' => '', 'nama' => '', 'prodi' => '', 'alamat' => '');

        $hitung = count(array_intersect_key($_POST, $arrcheckpost));
        if ($hitung == count($arrcheckpost)) {
            $stmt = $mysqli->prepare("UPDATE mahasiswa SET nim = ?, nama = ?, prodi = ?, alamat = ? WHERE id = ?");
            $stmt->bind_param("ssssi", $_POST['nim'], $_POST['nama'], $_POST['prodi'], $_POST['alamat'], $id);
            
            if ($stmt->execute()) {
                $response = array(
                    'status' => 1,
                    'message' => 'Data Mahasiswa Updated Successfully.'
                );
            } else {
                $response = array(
                    'status' => 0,
                    'message' => 'Data Mahasiswa Update Failed: ' . $stmt->error
                );
            }

            $stmt->close();
        } else {
            $response = array(
                'status' => 0,
                'message' => 'Parameter Do Not Match'
            );
        }

        header('Content-Type: application/json');
        echo json_encode($response);
    }

    // Method untuk menghapus data mahasiswa
    public function delete_mahasiswa($id) {
        global $mysqli;
        $stmt = $mysqli->prepare("DELETE FROM mahasiswa WHERE id = ?");
        if ($stmt) {
            $stmt->bind_param('i', $id);

            if ($stmt->execute()) {
                $response = array(
                    'status' => 1,
                    'message' => 'Data Mahasiswa Deleted Successfully.'
                );
            } else {
                $response = array(
                    'status' => 0,
                    'message' => 'Data Mahasiswa Deletion Failed: ' . $stmt->error
                );
            }

            $stmt->close();
        } else {
            $response = array(
                'status' => 0,
                'message' => 'Statement preparation failed: ' . $mysqli->error
            );
        }

        header('Content-Type: application/json');
        echo json_encode($response);
    }
}
?>
