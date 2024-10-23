//   const express = require("express");
//   const mysql = require("mysql2");
//   const cors = require("cors");

//   const app = express();
//   const port = 3000;

//   app.use(cors());
//   app.use(express.json());

//   // MySQL connection
//   const connection = mysql.createConnection({
//     host: "   192.168.119.202", // Adjust as necessary
//     user: "SubramanianG",
//     password: "Subramanian578",
//     database: "transport",
//   });

//   // Connect to MySQL
//   connection.connect((err) => {
//     if (err) {
//       console.error("Database connection failed:", err);
//       return;
//     }
//     console.log("Connected to MySQL database");
//   });

//   // API to fetch faculty-related data by email
// // API to fetch faculty-related data by email
// app.get("/", (req, res) => {
//   const { email } = req.query;

//   if (!email) {
//       return res.status(400).send("Email is required");
//   }

//   const query = `
//     SELECT m_faculty.name, m_faculty.email, bus_stop.stop_name, bus_stop.bus_no
//     FROM m_faculty
//     JOIN bus_stop ON m_faculty.id = bus_stop.faculty_id
//     WHERE m_faculty.email = ?;
//   `;

//   // Execute the query
//   connection.query(query, [email], (err, results) => {
//       if (err) {
//           console.error("Error fetching data:", err);
//           res.status(500).send("Failed to fetch mapped data");
//           return;
//       }

//       if (results.length === 0) {
//           res.status(404).send("No data found for the provided email");
//       } else {
//           res.json(results);
//       }
//   });
// });

//   // API to fetch bus_stop data
//   app.get("/bus_stop", (req, res) => {
//     const query = "SELECT id, stop_name, bus_no FROM bus_stop";
//     connection.query(query, (err, results) => {
//       if (err) {
//         console.error("Error fetching data from bus_stop:", err);
//         res.status(500).send("Failed to fetch data from bus_stop");
//         return;
//       }
//       res.json(results);
//     });
//   });

//   // API to fetch student data
//   app.get("/m_students", (req, res) => {
//     const query = "SELECT id, roll_number, name, gender, seat_no FROM m_students";
//     connection.query(query, (err, results) => {
//       if (err) {
//         console.error("Error fetching data from m_students:", err);
//         res.status(500).send("Failed to fetch data from m_students");
//         return;
//       }
//       res.json(results);
//     });
//   });

//   // API to fetch faculty data
//   app.get("/m_faculty", (req, res) => {
//     const query = "SELECT id, email FROM m_faculty";
//     connection.query(query, (err, results) => {
//       if (err) {
//         console.error("Error fetching data from m_faculty:", err);
//         res.status(500).send("Failed to fetch data from m_faculty");
//         return;
//       }
//       res.json(results);
//     });
//   });

//   // Start the server
//   app.listen(port, () => {
//     console.log(`Server running at http://   192.168.119.202:${port}`);
//   });
// const express = require("express");
// const mysql = require("mysql2");
// const cors = require("cors");

// const app = express();
// const port = 3000;

// app.use(cors());
// app.use(express.json());

// // MySQL connection
// const connection = mysql.createConnection({
//   host: "192.168.119.202",
//   user: "SubramanianG",
//   password: "Subramanian578",
//   database: "transport",
// });

// // Connect to MySQL
// connection.connect((err) => {
//   if (err) {
//     console.error("Database connection failed:", err);
//     return;
//   }
//   console.log("Connected to MySQL database");
// });

// // API to fetch bus_stop data with present and absent counts
// app.get("/bus_stop", (req, res) => {
//   const query = `
//     SELECT
//       bus_stop.id,
//       bus_stop.stop_name,
//       bus_stop.bus_no,
//       COUNT(CASE WHEN m_students.status = 'present' THEN 1 END) AS present_count,
//       COUNT(CASE WHEN m_students.status = 'absent' THEN 1 END) AS absent_count
//     FROM bus_stop
//     LEFT JOIN m_students ON bus_stop.id = m_students.bus_stop_id
//     GROUP BY bus_stop.id;
//   `;

//   connection.query(query, (err, results) => {
//     if (err) {
//       console.error("Error fetching data from bus_stop:", err);
//       res.status(500).send("Failed to fetch data from bus_stop");
//       return;
//     }
//     res.json(results);
//   });
// });

// // API to fetch faculty-related data by email
// app.get("/", (req, res) => {
//   const { email } = req.query;

//   if (!email) {
//     return res.status(400).send("Email is required");
//   }

//   const query = `
//     SELECT m_faculty.name, m_faculty.email, bus_stop.stop_name, bus_stop.bus_no
//     FROM m_faculty
//     JOIN bus_stop ON m_faculty.id = bus_stop.faculty_id
//     WHERE m_faculty.email = ?;
//   `;

//   // Execute the query
//   connection.query(query, [email], (err, results) => {
//     if (err) {
//       console.error("Error fetching data:", err);
//       res.status(500).send("Failed to fetch mapped data");
//       return;
//     }

//     if (results.length === 0) {
//       res.status(404).send("No data found for the provided email");
//     } else {
//       res.json(results);
//     }
//   });
// });

// app.get('/attendance', (req, res) => {
//   const stopName = req.query.stop_name;
//   const query = `
//     SELECT m_students.id, m_students.roll_number, m_students.name, m_students.gender, m_students.seat_no, bus_stop.stop_name
//     FROM m_students
//     JOIN bus_stop ON bus_stop.id = m_students.stop_name
//     WHERE bus_stop.stop_name = ?`;

//   connection.query(query, [stopName], (err, results) => {
//     if (err) {
//       console.error('Error fetching attendance data:', err);
//       res.status(500).send('Failed to fetch attendance data');
//       return;
//     }
//     res.json(results);
//   });
// });

// // API to fetch student data
// app.get("/m_students", (req, res) => {
//   const query = "SELECT id, roll_number, name, gender, seat_no FROM m_students";
//   connection.query(query, (err, results) => {
//     if (err) {
//       console.error("Error fetching data from m_students:", err);
//       res.status(500).send("Failed to fetch data from m_students");
//       return;
//     }
//     res.json(results);
//   });
// });

// // API to fetch faculty data
// app.get("/m_faculty", (req, res) => {
//   const query = "SELECT id, email FROM m_faculty";
//   connection.query(query, (err, results) => {
//     if (err) {
//       console.error("Error fetching data from m_faculty:", err);
//       res.status(500).send("Failed to fetch data from m_faculty");
//       return;
//     }
//     res.json(results);
//   });
// });

// // Start the server
// app.listen(port, () => {
//   console.log(`Server running at http://192.168.119.202:${port}`);
// });

const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

// MySQL connection
const connection = mysql.createConnection({
  host: "192.168.119.202", // Adjust as necessary
  user: "SubramanianG",
  password: "Subramanian578",
  database: "transport",
});

// Connect to MySQL
connection.connect((err) => {
  if (err) {
    console.error("Database connection failed:", err);
    return;
  }
  console.log("Connected to MySQL database");
});

// API to fetch faculty-related data by email
app.get("/", (req, res) => {
  const { email } = req.query;

  if (!email) {
    return res.status(400).send("Email is required");
  }

  const query = `
    SELECT m_faculty.name, m_faculty.email, bus_stop.stop_name, bus_stop.bus_no
    FROM m_faculty
    JOIN bus_stop ON m_faculty.id = bus_stop.faculty_id
    WHERE m_faculty.email = ?;
  `;

  connection.query(query, [email], (err, results) => {
    if (err) {
      console.error("Error fetching data:", err);
      res.status(500).send("Failed to fetch mapped data");
      return;
    }

    if (results.length === 0) {
      res.status(404).send("No data found for the provided email");
    } else {
      res.json(results);
    }
  });
});

// API to fetch attendance data by stop name
// API to fetch attendance data by stop name
app.get("/attendance", (req, res) => {
  const stopName = req.query.stop_name;
  if (!stopName) {
    return res.status(400).send("Stop name is required");
  }

  // const query = `
  //   SELECT m_students.id, m_students.roll_number, m_students.name, m_students.gender, m_students.seat_no, bus_stop.stop_name
  //   FROM m_students
  //   JOIN bus_stop ON bus_stop.id = m_students.bus-stop
  //   WHERE bus_stop.stop_name = ?;
  // `;
  const query = `
  SELECT m_students.id, m_students.roll_number, m_students.name, m_students.gender, m_students.seat_no, bus_stop.stop_name 
  FROM m_students 
  JOIN bus_stop ON bus_stop.id = m_students.\`bus-stop\`
  WHERE bus_stop.stop_name = ?;
`;

  connection.query(query, [stopName], (err, results) => {
    if (err) {
      console.error("Error fetching attendance data:", err);
      res.status(500).send("Failed to fetch attendance data");
      return;
    }
    res.json(results);
  });
});

// app.get("/m_students", (req, res) => {
//   const query = "SELECT id, roll_number, name, gender, seat_no,bus_no FROM m_students";
//   connection.query(query, (err, results) => {
//     if (err) {
//       console.error("Error fetching data from m_students:", err);
//       res.status(500).send("Failed to fetch data from m_students");
//       return;
//     }
//     res.json(results);
//   });
// });
// API to fetch student data
// API to fetch student data
// API to fetch student data by bus number
// API to fetch student data by bus number
// API to fetch student data by bus number
app.get("/m_students", (req, res) => {
  const busNo = req.query.bus_no; // Expect bus_no to be passed as a query parameter

  if (!busNo) {
    return res.status(400).send("Bus number is required");
  }

  const query = `
    SELECT m_students.id, m_students.roll_number, m_students.name, 
           m_students.gender, m_students.seat_no, 
           m_students.bus_no, GROUP_CONCAT(bus_stop.stop_name) AS stop_names
    FROM m_students 
    JOIN bus_stop ON m_students.bus_no = bus_stop.bus_no
    WHERE m_students.bus_no = ?
    GROUP BY m_students.id, m_students.roll_number, m_students.name, 
             m_students.gender, m_students.seat_no, m_students.bus_no;
  `;

  connection.query(query, [busNo], (err, results) => {
    if (err) {
      console.error("Error fetching data from m_students:", err);
      res.status(500).send("Failed to fetch data from m_students");
      return;
    }
    res.json(results);
  });
});

// API to fetch faculty data
app.get("/m_faculty", (req, res) => {
  const query = "SELECT id, email FROM m_faculty";
  connection.query(query, (err, results) => {
    if (err) {
      console.error("Error fetching data from m_faculty:", err);
      res.status(500).send("Failed to fetch data from m_faculty");
      return;
    }
    res.json(results);
  });
});

// Start the server
app.listen(port, () => {
  console.log(`Server running at http://192.168.119.202:${port}`);
});
