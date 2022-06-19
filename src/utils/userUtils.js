export const signin = async (email, password) => {
  const response = await fetch(
    `http://localhost:8000/microservice/accountService/admin/login-admin`,
    {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        password,
        email,
      }),
    }
  );
  return response;
};
