export const getJobs = async (token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/jobService/employer/jobPost",

    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    }
  );
  return response;
};

export const getJobsById = async (id, token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/jobService/employer/jobPost/singlePost/" +
      id,
    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    }
  );
  return response;
};

export const deleteJobPostById = async (id, token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/jobService/employer/jobPost/" + id,
    {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    }
  );
  return response;
};
