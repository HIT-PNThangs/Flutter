class BetterPlayerAsmsSubtitleSegment {
  ///Start of the subtitles counting from the start of the video.
  final Duration startTime;

  ///End of the subtitles counting from the start of the video.
  final Duration endTime;

  ///Real url of the subtitles (with all domains and paths).
  final String realUrl;

  BetterPlayerAsmsSubtitleSegment(this.startTime, this.endTime, this.realUrl);
}
