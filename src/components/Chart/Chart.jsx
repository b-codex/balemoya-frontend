import "./Chart.scss";
import React, { PureComponent, useEffect, useState } from "react";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  Area,
  AreaChart,
  ResponsiveContainer,
} from "recharts";
import { getUsers } from "../../utils/customer";
import moment from "moment";

const Chart = () => {
  const [users, setUsers] = useState([]);
  const [err, setErr] = useState("");
  const [totalUsers, setTotalUsers] = useState(0);
  useEffect(() => {
    // add user tokens inside the param
    getUsers()
      .then((res) => res.json())
      .then((data) => {
        setUsers(data);
        // setTotalUsers(data.length)
        console.log("aaa" + data.length());
      })
      .catch((_) => {
        setErr("Something went wrong");
      });
  }, []);

  const chartData = [];
  const employee = [];
  const employer = [];
  const accountType = () => {
    for (var i = 0; i < users.length; i++) {
      chartData.push(users[i].role);
      if (users[i].role == "employee") {
        employee.push(users[i].role);
      } else if (users[i].role == "employer") {
        employer.push(users[i].role);
      }
    }
  };
  accountType();

  const creationList = [];
  const momented = [];
  const createdAt = () => {
    for (var i = 0; i < users.length; i++) {
      creationList.push(users[i].createdAt);
      momented.push(moment(users[i].createdAt).format("MM/DD/YYYY"));
    }
  };
  createdAt();

  const uniqueCreationDates = [...new Set(momented)];

  const accountsPerDay = () => {
    for (var i = 0; i < creationList; i++) {
      if (creationList[i] in creationList[i + 1]) {
        console.log("uessefsdas");
      } else {
        console.log("nooo");
      }
    }
  };
  accountsPerDay();

  createdAt();
  let today = new Date().toLocaleDateString();
  const firstSignup = moment(creationList[0]).format("MM/DD/YYYY");
  const data = [
    {
      name: uniqueCreationDates[0],
      Employees: employee.length,
      Companies: employer.length,
    },
    {
      name: uniqueCreationDates[1],
      Employees: employee.length,
      Companies: employer.length,
    },
    {
      name: today,
      Employees: employee.length,
      Companies: employer.length,
    },
  ];

  return (
    <div className="chart">
      {/* <ResponsiveContainer> */}
      <LineChart
        className="line_chart"
        width={800}
        height={500}
        data={data}
        margin={{
          top: 5,
          right: 30,
          left: 20,
          bottom: 5,
        }}
      >
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="name" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Line
          type="monotone"
          dataKey="Employees"
          stroke="#8884d8"
          activeDot={{ r: 8 }}
        />
        <Line type="monotone" dataKey="Companies" stroke="#82ca9d" />
      </LineChart>
      {/* </ResponsiveContainer> */}
    </div>
  );
};

export default Chart;
