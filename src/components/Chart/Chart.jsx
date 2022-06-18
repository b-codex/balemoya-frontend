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

const data = [
  {
    name: "May",
    "Male Users": 40,
    "Female Users": 24,
    amt: 2400,
  },
  {
    name: "June",
    "Male Users": 32,
    "Female Users": 48,
    amt: 2210,
  },
  {
    name: "July",
    "Male Users": 156,
    "Female Users": 192,
    amt: 2290,
  },
  {
    name: "August",
    "Male Users": 84,
    "Female Users": 74,
    amt: 2000,
  },
  {
    name: "September",
    "Male Users": 180,
    "Female Users": 160,
    amt: 2181,
  },
  {
    name: "October",
    "Male Users": 290,
    "Female Users": 310,
    amt: 2500,
  },
];

const Chart = () => {
  const [users, setUsers] = useState([]);
  const [err, setErr] = useState("");
  const [totalUsers, setTotalUsers] = useState(0)
  useEffect(() => {
    // add user tokens inside the param
    getUsers()
      .then((res) => res.json())
      .then((data) => {
        setUsers(data);
        // setTotalUsers(data.length)
        console.log('aaa'+data.length());
      })
      .catch((_) => {
        setErr("Something went wrong");
      });
  }, []);
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
          dataKey="Female Users"
          stroke="#8884d8"
          activeDot={{ r: 8 }}
        />
        <Line type="monotone" dataKey="Male Users" stroke="#82ca9d" />
      </LineChart>
      {/* </ResponsiveContainer> */}
    </div>
  );
};

export default Chart;
