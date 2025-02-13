/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
console.log("success");
function validatePhone(input) {
    input.value = input.value.replace(/[^0-9]/g, '');
    if (input.value.length > 10) {
        input.value = input.value.slice(0, 10);
    }
    if (input.value.length < 10) {
        input.setCustomValidity("Phone number must be 10 digits long.");
    } else {
        input.setCustomValidity(""); 
    }
}


function validateFileInput(input, id) {
    const filePath = input.value;
    const allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;

    if (!allowedExtensions.exec(filePath)) {
        alert('Please select a file in .jpg or .png format.');
        input.value = '';
        return false;
    } else {
        displayImage2(input, id);
    }
}




