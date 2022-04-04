import React from "react";
import "./Featured.scss";
import MoreVertOutlinedIcon from "@mui/icons-material/MoreVertOutlined";
import { CircularProgressbar } from "react-circular-progressbar";
import "react-circular-progressbar/dist/styles.css";
import KeyboardArrowUpIcon from "@mui/icons-material/KeyboardArrowUp";
import KeyboardArrowDownIcon from "@mui/icons-material/KeyboardArrowDown";

const Featured = () => {
  return (
    <div className="featured">
      <div className="top">
        <h1 className="title">Total Revenue</h1>
        <MoreVertOutlinedIcon fontSize="small" />
      </div>
      <div className="bottom">
        <div className="featured_chart">
          <CircularProgressbar value={69} text={"69%"} strokeWidth={3} />
        </div>
        <p className="title">Total percent of users who signed up today</p>
        <p className="amount">32</p>
        <p className="desc">
          {/* Previous transactions processing. Last payments may not be included. */}
        </p>
        <div className="summary">
          <div className="item">
            <div className="item_title">Overall</div>
            <div className="item_result positive">
              <KeyboardArrowUpIcon fontSize="small" />
              <div className="result_amount">62</div>
            </div>
          </div>
          <div className="item">
            <div className="item_title">Last Week</div>
            <div className="item_result negative">
              <KeyboardArrowDownIcon fontSize="small" />
              <div className="result_amount">-6</div>
            </div>
          </div>
          <div className="item">
            <div className="item_title">Last Month</div>
            <div className="item_result positive">
              <KeyboardArrowUpIcon fontSize="small" />
              <div className="result_amount">150</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Featured;
