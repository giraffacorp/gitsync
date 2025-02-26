FROM alpine:3.21

# install dependencies 
RUN apk add --no-cache git rsync openssh-client go-task

# set working directory and copy the application code
WORKDIR /app
COPY . .

# configure environment 
ENV GIT_HOST="github.com" \
    GIT_REPO_URL="" \
    GIT_SUBFOLDER_PATH="" \
    GIT_BRANCH="main" \
    SYNC_INTERVAL=10

# run task
ENTRYPOINT ["go-task"]
CMD ["watch"]
