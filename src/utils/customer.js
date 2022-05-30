
  export const getUsers = async () => {
    const response = await fetch("http://localhost:5655/microservice/accountService/users/", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    });
    return response;
  };