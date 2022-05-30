import React, { useState } from "react";
import { Link } from "react-router-dom";
import "./Login.scss";
import { Button, Checkbox, Form, Input } from "antd";
import { signin } from "../../utils/userUtils";
import { useDispatch } from "react-redux";
import { login } from "../../redux/userSlice";
import { useNavigate } from "react-router-dom";
const Login = () => {
  const dispatch = useDispatch()
  let navigate = useNavigate();
  const onFinish = (values) => {
    signin(values.username, values.password)
    .then((res) => res.json())
    .then((data) => {
      console.log(data)
      if (data.success === true){
        console.log('#####################')
        dispatch(login({
          email: data.email,
          expiryDate: data.expiryDate,
          name: data.name,
          role: data.role,
          success: data.success,
          token: data.token,
        }))
        navigate(`/`);
      }
    })
    .catch((_) => {
      console.log('Something went wrong')
    })
  };
  const onFinishFailed = (errorInfo) => {
    console.log("Failed:", errorInfo);
  };
  return (
    <div className="login">
      <div className="left_div">
        <h1>Login</h1>
        <p>View user stat and analytics</p>
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
            label="Username"
            name="username"
            rules={[
              {
                required: true,
                message: "Please input your username!",
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
            <Checkbox>Remember me</Checkbox>
          </Form.Item>

          <Form.Item
            wrapperCol={{
              offset: 8,
              span: 16,
            }}
          >
            <Button type="primary" htmlType="submit">
              Submit
            </Button>
          </Form.Item>
        </Form>
        <div className="not_reg">
          <p className="not_reg_para">Not registered yet?</p>
          <Link
            className="not_reg_link"
            to="/signup"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <a href="">Create an Account</a>
          </Link>
        </div>
      </div>
      <div className="right_div"></div>
    </div>
  );
};

export default Login;
