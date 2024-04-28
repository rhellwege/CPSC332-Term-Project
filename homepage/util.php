<?php
// Accepts  SQL query result and returns the result in a cusomized HTML <table>
// Automatically fills column headers as the field names of the query result
// Returns HTML string
function format_sql_result(mysqli_result $result): string
{
    if ($result->num_rows === 0) {
        return "<span>0 results</span>";
    }

    $output = "<table>";
    $fields = $result->fetch_fields();

    // The first row of the table is the headers
    $output .= "<tr>";
    foreach ($fields as $field) {
        $output .= "<th>$field->name</th>";
    }
    $output .= "</tr>";

    // Output data of each row
    while ($row = $result->fetch_row()) {
        $output .= "<tr>";
        foreach ($row as $value) {
            $output .= "<td>$value</td>";
        }
        $output .= "</tr>";
    }

    $output .= "</table>";
    return $output;
}

?>
