# transcode-fansubs

https://hub.docker.com/r/jerieljan/transcode-fansubs

This Docker image uses `ffmpeg` to convert all files in the provided directory to h265 `-crf 24` quality.

Recommended for those who want to shrink down the file sizes of their video files encoded in h264, while having a good balance of quality.

NOTE: Once run, this will loop through all files in the `/data` directory, run `ffmpeg` and if successful, will *remove* your original file. It'll only do this if the transcode was successful, but keep this in mind.

## Usage

```bash
docker run -v $(pwd):/data \
             -it --rm \
             jerieljan/transcode-fansubs:1.0
```

## Building

docker build -d transcode-fansubs .