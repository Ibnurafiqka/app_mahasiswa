<?php
require_once "file_method.php";
$mahasiswa = new mahasiswa();
$request_method = $_SERVER["REQUEST_METHOD"];

switch ($request_method) {

    case 'GET':
        if (!empty($_GET["prodi"])) {
            $prodi = $_GET["prodi"];
            $mahasiswa->get_datamahasiswa($prodi);
        } else if (isset($_GET["list_prodi"])) {
            $mahasiswa->get_prodilist();
        } else {
            $mahasiswa->get_allmahasiswa();
        }
        break;

    case 'POST':
        if (!empty($_GET["id"])) {
            $id = intval($_GET["id"]);
            $mahasiswa->update_mahasiswa($id);
        } else {
            $mahasiswa->insert_mahasiswa();
        }
        break; 

    case 'DELETE':
        // Ensure that the ID is passed correctly for deletion
        if (!empty($_GET["id"])) {
            $id = intval($_GET["id"]);
            $mahasiswa->delete_mahasiswa($id);
        } else {
            // If ID is not provided, send an error response
            header("HTTP/1.0 400 Bad Request");
            echo json_encode(array("status" => 0, "message" => "ID not provided for deletion."));
        }
        break; 

    default:
        // Invalid Request Method
        header("HTTP/1.0 405 Method Not Allowed");
        break;
}
?>
