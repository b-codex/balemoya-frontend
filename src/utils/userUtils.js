export const getUsers = async () => {
  let res = await fetch(
    "http://localhost:5655/microservice/accountService/users/"
  );
  return await res.json();
};
