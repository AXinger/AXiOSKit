//
//  LameHelper.m
//  BigApple
//
//  Created by liuweixing on 2016/11/16.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "LameHelper.h"
//#import "lame.h"
@implementation LameHelper

//+(BOOL )toMp3WithSourcePath:(NSString *)sourcePath mp3Path:(NSString *)mp3Path{
//
//    NSString *cafFilePath = sourcePath;    //caf文件路径
//
//    NSString *mp3FilePath = mp3Path;//存储mp3文件的路径
//
//    NSFileManager * fileManager=[ NSFileManager defaultManager ];
//
//    if ([fileManager removeItemAtPath :mp3FilePath error : nil ])
//
//    {
//
//        NSLog ( @" 删除 " );
//
//    }
//
//
//
//    @try {
//
//        int read, write;
//
//        FILE *pcm = fopen ([cafFilePath cStringUsingEncoding : 1 ], "rb" );  //source 被 转换的音频文件位置
//
//        if (pcm == NULL )
//
//        {
//
//            NSLog ( @"file not found" );
//
//        }
//
//        else
//
//        {
//
//            fseek (pcm, 4 * 1024 , SEEK_CUR );                                   //skip file header
//
//            FILE *mp3 = fopen ([mp3FilePath cStringUsingEncoding : 1 ], "wb" );  //output 输出生成的 Mp3 文件位置
//
//
//
//            const int PCM_SIZE = 8192 ;
//
//            const int MP3_SIZE = 8192 ;
//
//            short int pcm_buffer[PCM_SIZE* 2 ];
//
//            unsigned char mp3_buffer[MP3_SIZE];
//
//
//
//            lame_t lame = lame_init ();
//
//            lame_set_num_channels (lame, 2 ); // 设置 1 为单通道，默认为 2 双通道
//
//            lame_set_in_samplerate (lame, 8000.0 ); //11025.0
//
//            //lame_set_VBR(lame, vbr_default);
//
//            lame_set_brate (lame, 8 );
//
//            lame_set_mode (lame, 3 );
//
//            lame_set_quality (lame, 2 ); /* 2=high 5 = medium 7=low 音 质 */
//
//            lame_init_params (lame);
//
//
//
//            do {
//
//                read = (int)fread (pcm_buffer, 2 * sizeof ( short int ), PCM_SIZE, pcm);
//
//                if (read == 0 )
//
//                    write = lame_encode_flush (lame, mp3_buffer, MP3_SIZE);
//
//                else
//
//                    write = lame_encode_buffer_interleaved (lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
//
//
//
//                fwrite (mp3_buffer, write, 1 , mp3);
//
//
//
//            } while (read != 0 );
//
//
//
//            lame_close (lame);
//
//            fclose (mp3);
//
//            fclose (pcm);
//
//            return YES ;
//
//        }
//
//        return NO ;
//
//    }
//
//    @catch (NSException *exception) {
//
//        NSLog ( @"%@" ,[exception description ]);
//
//        return NO ;
//
//    }
//
//    @finally {
//
//        NSLog ( @" 执行完成 " );
//        return YES ;
//
//    }
//}


@end
