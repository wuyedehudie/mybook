
### 色彩模型
#### RGB
RGB：直接使用红、绿、蓝三种颜色表示图像颜色，是最直观的颜色空间。
- 色彩直接，适用于显示设备，尤其是在屏幕显示和图像处理时效果好。
- 不经过压缩，可以确保色彩的精确性，适合图像处理和编辑。
- 数据量大，不适合视频压缩和传输。
- 人眼对亮度和色度的感知不同，RGB 不能充分利用这一特性进行数据压缩。
#### YUV(444,422,420) 色彩,亮度,

YUV：将亮度与色度分离，亮度信息（Y）独立存储，色度信息（U 和 V）可以进行压缩。YUV 更贴合人眼对亮度和色度的感知特性。
- 色度可以压缩（色度子采样），显著降低视频文件的存储空间和带宽占用。
更适合视频编码和传输，能够在不明显影响画质的前提下实现高效压缩。
- 需要转换为 RGB 才能在显示设备上呈现，增加了计算开销。
在压缩过程中可能导致色彩损失，尤其是在过度压缩的情况下，色度信息不够精确。


### Fast Forward mpeg

输出文件比特率，输入输出文件的帧率，-r 设置帧率
- 设置输出文件的视频比特率为64kbit/s
ffmpeg -i input.avi -b:v 64k -bufsize 64k output.avi
- 设置输出文件的帧率强制为24 fps
ffmpeg -i input.avi -r 24 output.avi
- 设置输入文件的帧率为1 fps ，输出文件的帧率为24fps
ffmpeg -r 1 -i input.m2v -r 24 output.avi

流程解析
---
- Demuxer将音频、视频、字幕轨道分离
- decoder解码器，将数据解码成可播放的音频/视频模式///muxer和coder则相反
- Encoder data packet是指由编码器生成的数据包,通常以二进制的形式村庄
![Alt text](%E6%B5%81%E7%A8%8B.png)

实操
---
**1.安装了ffmpeg可直接使用**
> ffplay music.mp3

按q或esc退出，f全屏，p暂停，w切换显示模式
**2.查看媒体参数信息**
> ffprobe video.mp4

**3.转换格式**
> ffmpeg -i video.mp4 video.avi //-i，即input，指定输入文件

**4.合并,提取音视频**
(1)单独提取视频（不含音频流）
> ffmpeg -i video.mp4 -map a output.mp3

> 
(2)单独提取音频（不含视频流）
> ffmpeg -i video.mp4 -vn -acodec copy video_novideo.m4a

**.改变编码 下(码率控制模式)**
> ffmpeg支持的码率控制模式：-qp -crf -b
(1)
-qp :constant quantizer,恒定量化器模式
无损压缩的例子（快速编码）
ffmpeg -i input -vcodec libx264 -preset ultrafast -qp 0 output.mkv
无损压缩的例子（高压缩比）
ffmpeg -i input -vcodec libx264 -preset veryslow -qp 0 output.mkv
(2)
-crf :constant rate factor,恒定速率因子模式
(3)
-b ：bitrate,固定目标码率模式。一般不建议使用



.改变编码
(1)视频转码
> ffmpeg -i video.mp4 -s 1920x1080 -pix_fmt yuv420p -vcodec libx264 -preset medium -profile:v high -level:v 4.1 -crf 23 -acodec aac -ar 44100 -ac 2 -b:a 128k video_avi.avi

说明:
> -s 1920x1080：缩放视频新尺寸(size)
-pix_fmt yuv420p：pixel format,用来设置视频颜色空间。参数查询：ffmpeg -pix_fmts
-vcodec libx264：video Coder Decoder，视频编码解码器
-preset medium: 编码器预设。参数：ultrafast,superfast,veryfast,faster,fast,medium,slow,slower,veryslow,placebo
-profile:v high :编码器配置，与压缩比有关。实时通讯-baseline,流媒体-main,超清视频-high

-crf 23 ：设置码率控制模式。constant rate factor-恒定速率因子模式。范围0~51,默认23。数值越小，画质越高。一般在8~28做出选择。

-acodec aac :audio Coder Decoder-音频编码解码器
-b:a 128k :音频比特率.大多数网站限制音频比特率128k,129k

命令参数整理
----
-r 30 :设置视频帧率
- vn //no video,不处理视频流
-level:v 4.1 ：对编码器设置的具体规范和限制，权衡压缩比和画质。

多媒体处理术语
----
> Codec（编解码器）：Codec 是编码器和解码器的组合。用于将原始音频或视频数据编码成压缩格式，然后再解码以进行播放或处理。
Container Format（容器格式）：容器格式是一种文件格式，可以包含多个音频、视频、字幕轨道以及相关元数据。常见的容器格式包括MP4、AVI、MKV、MOV等。
Bitrate（比特率）：比特率是描述音频或视频压缩级别的度量单位。越高音频质量越好
Frame（帧）：在视频处理中，帧是单个图像或画面的单位。视频由一系列连续的帧组成，以在播放时创建动画效果。
Sampling Rate（采样率）：每秒采样次数。它影响了音频质量和文件大小。通常以Hz为单位，例如44.1kHz。
Resolution（分辨率）：分辨率是图像或视频的大小，通常以像素表示。高分辨率图像具有更多的像素，因此通常具有更高的质量，但文件大小也更大。
Streaming（流媒体）：流媒体是一种通过互联网实时传输音频或视频的方式，而不需要等待整个文件下载完毕。用户可以在文件下载的同时观看或听取内容。
Metadata（元数据）：元数据是关于多媒体文件的信息，如标题、艺术家、时长、创建日期等。它有助于组织和检索多媒体内容。
Chroma Key（色度键合）：色度键合是一种特殊的视频合成技术，用于将一个视频中的特定颜色（通常是绿色或蓝色）替换为其他内容，以创建特殊效果。
Rendering（渲染）：处理和呈现出可视或可听的形式的过程。

关于数据包
---
> **音频编码数据包**：对于音频编码，数据包通常包含一小段音频样本，经过编码器处理后，以压缩格式（如AAC、MP3）进行编码。每个数据包包含一段时间内的音频数据，通常以毫秒为单位。
**视频编码数据包**：对于视频编码，数据包包含一组连续的视频帧，这些帧经过编码器处理并以压缩格式（如H.264、VP9）编码。每个数据包通常包含多个视频帧，可以表示为关键帧（I帧）或非关键帧（P帧、B帧）等。
**图像编码数据包**：对于图像编码，数据包包含经过编码器处理的图像数据，通常以压缩格式（如JPEG）编码。每个数据包包含一个图像帧。
**数据包的传输**：这些编码数据包可以通过网络传输、存储在文件中或发送到解码器以进行播放。在传输过程中，数据包的顺序和时序信息通常是关键的，以确保正确的解码和播放。
