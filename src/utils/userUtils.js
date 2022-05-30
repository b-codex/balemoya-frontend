export const signin = async (name, password) => {
  const response = await fetch(`http://localhost:5655/microservice/accountService/admin/login-admin`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      password,
      name,
    }),
  });
  return response;
};