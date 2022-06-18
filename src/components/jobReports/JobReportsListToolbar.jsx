import {
  Box,
  Button,
  Card,
  CardContent,
  TextField,
  InputAdornment,
  SvgIcon,
  Typography,
} from "@mui/material";
import { SearchOutlined } from "@mui/icons-material";
export const JobReportsListToolbar = (props) => {
  return (
    <Box {...props}>
      <Box
        sx={{
          alignItems: "center",
          display: "flex",
          justifyContent: "space-between",
          flexWrap: "wrap",
        }}
      >
        <Typography sx={{ m: 1 }} variant="h4">
          {props.name}
        </Typography>
      </Box>
      <Box sx={{ mt: 2 }}>
        <Card>
          <CardContent>
            <Box sx={{ maxWidth: 400 }}>
              <TextField
                onChange={(event) => props.setSearchTerm(event.target.value)}
                fullWidth
                InputProps={{
                  startAdornment: (
                    <InputAdornment position="start">
                      <SvgIcon color="action" fontSize="small">
                        <SearchOutlined />
                      </SvgIcon>
                    </InputAdornment>
                  ),
                }}
                placeholder="Search Reported Users"
                variant="outlined"
              />
            </Box>
          </CardContent>
        </Card>
      </Box>
    </Box>
  );
};
