import React, { useEffect, useState } from "react";
import "./Featured.scss";
import MoreVertOutlinedIcon from "@mui/icons-material/MoreVertOutlined";
import { CircularProgressbar } from "react-circular-progressbar";
import "react-circular-progressbar/dist/styles.css";
import KeyboardArrowUpIcon from "@mui/icons-material/KeyboardArrowUp";
import KeyboardArrowDownIcon from "@mui/icons-material/KeyboardArrowDown";
import { getUsers } from "../../utils/customer";
import moment from "moment";
import { selectUser } from "../../redux/userSlice";
import { useDispatch, useSelector } from "react-redux";


const Featured = () => {
  const user = useSelector(selectUser);
  const [users, setUsers] = useState([]);
  const [err, setErr] = useState("");
  useEffect(() => {
    getUsers(user.token)
      .then((res) => res.json())
      .then((data) => {
        setUsers(data);
      })
      .catch((_) => {
        setErr("Something went wrong");
      });
  }, []);

  const creationList = [];

  const createdAt = () => {
    for (var i = 0; i < users.length; i++) {
      creationList.push(users[i].createdAt);
    }
  };
  createdAt();

  const signupsToday = () => {
    var signupsToday = 0;
    var today = new Date().toLocaleDateString();
    for (var i = 0; i < creationList.length; i++) {
      var creationDate = new Date(creationList[i]);
      var Difference_In_Time = Date.parse(today) - Date.parse(creationDate);
      const Difference_In_Days = Math.floor(
        Difference_In_Time / (1000 * 3600 * 24)
      );
      if (Difference_In_Days <= 1) {
        signupsToday += 1;
      }
    }
    return signupsToday;
  };
  const signupsThisWeek = () => {
    var signupsThisWeek = 0;
    var today = new Date().toLocaleDateString();
    for (var i = 0; i < creationList.length; i++) {
      var creationDate = new Date(creationList[i]);
      var Difference_In_Time = Date.parse(today) - Date.parse(creationDate);
      const Difference_In_Days = Math.floor(
        Difference_In_Time / (1000 * 3600 * 24)
      );
      if (Difference_In_Days <= 7) {
        signupsThisWeek += 1;
      }
    }
    return signupsThisWeek;
  };
  const signupsThisMonth = () => {
    var signupsThisMonth = 0;
    var today = new Date().toLocaleDateString();
    for (var i = 0; i < creationList.length; i++) {
      var creationDate = new Date(creationList[i]);
      var Difference_In_Time = Date.parse(today) - Date.parse(creationDate);
      const Difference_In_Days = Math.floor(
        Difference_In_Time / (1000 * 3600 * 24)
      );
      if (Difference_In_Days <= 31) {
        signupsThisMonth += 1;
      }
    }
    return signupsThisMonth;
  };
  return (
    <div className="featured">
      <div className="top">
        <h1 className="title">User Accounts</h1>
        <MoreVertOutlinedIcon fontSize="small" />
      </div>
      <div className="bottom">
        <div className="featured_chart">
          <CircularProgressbar
            value={(signupsToday() / creationList.length) * 100}
            text={
              Math.round((signupsToday() / creationList.length) * 100) + "%"
            }
            strokeWidth={3}
          />
        </div>
        <p className="title">Percentage of users who signed up today</p>
        <p className="amount">{signupsToday()} Total Sign Up(s) today</p>
        <p className="desc">
          {/* Previous transactions processing. Last payments may not be included. */}
        </p>
        <div className="summary">
          <div className="item">
            <div className="item_title">Overall</div>
            <div className="item_result positive">
              <KeyboardArrowUpIcon fontSize="small" />
              <div className="result_amount">{creationList.length}</div>
            </div>
          </div>
          <div className="item">
            <div className="item_title">This Month</div>
            <div className="item_result positive">
              <KeyboardArrowUpIcon fontSize="small" />
              <div className="result_amount">{signupsThisMonth()}</div>
            </div>
          </div>{" "}
          <div className="item">
            <div className="item_title">This Week</div>
            <div className="item_result positive">
              <KeyboardArrowUpIcon fontSize="small" />
              <div className="result_amount">{signupsThisWeek()}</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Featured;
