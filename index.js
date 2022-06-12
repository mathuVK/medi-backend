const express = require("express");
const app = express();
const mysql = require("mysql");
const cors = require("cors");

app.use(cors());
app.use(express.json());

const connConfig = {
  user: "root",
  host: "localhost",
  password: "root@",
  database: "channeldoctor",
};
const db = mysql.createConnection(connConfig);
db.connect(function (err) {
  if (err) {
    console.log(err);
  } else {
    console.log("You are  connected with database");
  }
});

app.post("/SignUp", (req, res) => {
  const userName = req.body.userName;
  const email = req.body.email;
  const password = req.body.password;

  db.query(
    "INSERT INTO channeldoctor.user (User_name,email,Password) VALUES(?,?,?)",
    [userName, email, password],
    (err, result) => {
      if (err) {
        console.log(err);
      } else {
        res.send("value inserted");
      }
    }
  );
});

app.post("/SignIn", (req, res) => {
  const email = req.body.email;
  const Password = req.body.password;
  db.query(
    "SELECT * FROM user WHERE email=? AND password=?",
    [email, Password],
    (err, result) => {
      if (err) {
        res.send({ err: err });
        console.log(err);
      }
      if (result.length > 0) {
        res.send({ result });
        console.log("welcome to home page");
      } else {
        console.log("Wrong user name and password");
      }
    }
  );
});

app.post("/channel", (req, res) => {
  const DoctorName = req.body.Doctorname;
  const Hospitalname = req.body.Hospitalname;
  const Speciality_type = req.body.Speciality_type;
  const query1 = `
  SELECT Doctor.Doctor_id, Doctor.DoctorName, Hospital.Hospitalname, Hostpital_id, Speciality.Speciality_type 
  FROM Doctor 
  INNER JOIN HospitalhasDoctors ON Doctor.Doctor_id=HospitalhasDoctors.Doctor_id
  INNER JOIN Hospital ON HospitalhasDoctors.Hospital_id=Hospital.Hospital_id
  INNER JOIN Speciality ON Doctor.Speciality_id=Speciality.Speciality_id
  WHERE Speciality.Speciality_type='${Speciality_type}' OR Doctor.DoctorName='${DoctorName}' OR Hospital.Hospitalname='${Hospitalname}' 
  `;
  console.log(Speciality_type);
  db.query(query1, (err, result) => {
    if (err) {
      console.log(err);
      return res.status(500).send({ err: err });
    }
    console.log(result);
    if (result) {
      res.send(result);
    }
  });
});

app.listen(3001, () => {
  console.log("Background is runnning");
});
