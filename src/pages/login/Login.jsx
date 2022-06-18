import React, { useState } from "react";
import { Link } from "react-router-dom";
import "./Login.scss";
import { Button, Checkbox, Form, Input } from "antd";
import { signin } from "../../utils/userUtils";
import { useDispatch } from "react-redux";
import { login } from "../../redux/userSlice";
import { useNavigate } from "react-router-dom";
import logo from "./logo.png";
import Snackbar from "@mui/material/Snackbar";
import IconButton from "@mui/material/IconButton";
import CloseIcon from "@mui/icons-material/Close";
import Stack from "@mui/material/Stack";
import MuiAlert from "@mui/material/Alert";

const Login = () => {
  const Alert = React.forwardRef(function Alert(props, ref) {
    return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
  });
  const [open, setOpen] = React.useState(false);
  const handleClick = () => {
    setOpen(true);
  };
  const handleClose = (event, reason) => {
    if (reason === "clickaway") {
      return;
    }
    setOpen(false);
  };
  const action = (
    <React.Fragment>
      <Button color="secondary" size="small" onClick={handleClose}>
        OK
      </Button>
      <IconButton
        size="small"
        aria-label="close"
        color="inherit"
        onClick={handleClose}
      >
        <CloseIcon fontSize="small" />
      </IconButton>
    </React.Fragment>
  );
  const dispatch = useDispatch();
  let navigate = useNavigate();
  const onFinish = (values) => {
    signin(values.email, values.password)
      .then((res) => res.json())
      .then((data) => {
        if (data.success === true) {
          dispatch(
            login({
              email: data.email,
              expiryDate: data.expiryDate,
              name: data.name,
              role: data.role,
              success: data.success,
              token: data.token,
            })
          );
          navigate(`/`);
        } else {
          handleClick();
        }
      })
      .catch((_) => {
        console.log("Something went wrong");
      });
  };
  const onFinishFailed = (errorInfo) => {
    console.log("Failed:", errorInfo);
  };
  return (
    <div className="login">
      <div className="left_div">
        <div className="left_div_text">
          <div
            className="logo_div"
            style={{
              backgroundImage: `url(${logo})`,
              width: "280px",
              height: "90px",
              backgroundSize: "cover",
              backgroundRepeat: "no-repeat",
              backgroundPosition: "center",
            }}
          ></div>
          <br />
          <br />
          <h1>
            <strong>Login</strong>
          </h1>
          <p id="details">View user & job analytics!</p>
          <br />
        </div>
        <Form
          className="login_form"
          name="basic"
          labelCol={{
            span: 8,
          }}
          wrapperCol={{
            span: 16,
          }}
          initialValues={{
            remember: true,
          }}
          onFinish={onFinish}
          onFinishFailed={onFinishFailed}
          autoComplete="off"
        >
          <Form.Item
            label="Email"
            name="email"
            rules={[
              {
                required: true,
                message: "Please input your Email address!",
              },
            ]}
          >
            <Input />
          </Form.Item>

          <Form.Item
            label="Password"
            name="password"
            rules={[
              {
                required: true,
                message: "Please input your password!",
              },
            ]}
          >
            <Input.Password />
          </Form.Item>

          <Form.Item
            name="remember"
            valuePropName="checked"
            wrapperCol={{
              offset: 8,
              span: 16,
            }}
          >
            <Checkbox
              className="form_checkbox"
              style={{
                backgroundColor: "#5138ee !important",
                borderRadius: "8px",
                border: "none",
              }}
            >
              Remember me
            </Checkbox>
          </Form.Item>

          <Form.Item
            wrapperCol={{
              offset: 20,
              span: 16,
            }}
          >
            <Button
              type="primary"
              htmlType="submit"
              style={{
                backgroundColor: "#5138ee",
                borderRadius: "8px",
                border: "none",
              }}
            >
              Submit
            </Button>
          </Form.Item>
        </Form>
        <Stack spacing={2} sx={{ width: "100%" }}>
          <Snackbar open={open} autoHideDuration={6000} onClose={handleClose}>
            <Alert
              onClose={handleClose}
              severity="warning"
              sx={{ width: "100%" }}
            >
              Invalid Credentials!
            </Alert>
          </Snackbar>
        </Stack>
        <div className="left_div_footer">
          @2022 Balemoya. All rights reserved
        </div>
      </div>
      <div className="right_div"></div>
    </div>
  );
};

export default Login;
