package com.zhao.utils;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

public class Download {

	public static void getURLResource(String ourputFile, String urlStr) throws Exception

	{

		FileWriter fw = new FileWriter(ourputFile);

		PrintWriter pw = new PrintWriter(fw);

		URL resourceUrl = new URL(urlStr);

		InputStream content = (InputStream) resourceUrl.getContent();

		BufferedReader in = new BufferedReader(new InputStreamReader(content));

		String line;

		while ((line = in.readLine()) != null)

		{

			pw.println(line);

		}

		pw.close();

		fw.close();

	}

	public static void main(String[] args) {
		String url1 = "https://vod.changxianggu.com/70f3b8030ece4c06a83bbf3de123d094/bb249a80cdb247b09a14fb538e1a243e-30d47d2383dec8fd34e09014600c3189-hd-%s.ts";
		
		for (int i = 61; i < 449; i++) {
			String format = String.format("%05d",i);
			String url = String.format(url1, format);
			
			httpDownload(url, "E:\\vedio1\\"+format+".ts");
			System.out.println("end"+i);
		}
		
		String url2="https://vod.changxianggu.com/0c76682697b34e6eb72bac4a3ddcacfc/15339dcf68fe410f9b827a9b1c3e40a2-78a927c98e180cfe216309d4598b71c9-hd-%s.ts";
		for (int i = 1; i < 583; i++) {
			String format = String.format("%05d",i);
			String url = String.format(url2, format);
//			httpDownload(url, "E:\\vedio2\\"+format+".ts");
		}
		String url3="https://vod.changxianggu.com/7fb3906ad230416db65248652d320c67/fbdf4a2c2c0a4271878c341d4bbb0f89-cb396b138e8111fa54891d273c9bb430-hd-%s.ts";
		for (int i = 1; i < 404; i++) {
			String format = String.format("%05d",i);
			String url = String.format(url3, format);
//			httpDownload(url, "E:\\vedio3\\"+format+".ts");
		}
		String url4="https://vod.changxianggu.com/8f188c5be2664e239a695e244ac6aa38/9e9e0840e336442faa5ebbcec2932760-a0ebfdff25347f203cdf6446abec47f3-hd-%s.ts";
		for (int i = 1; i < 744; i++) {
			String format = String.format("%05d",i);
			String url  = String.format(url4, format);
//			httpDownload(url, "E:\\vedio4\\"+format+".ts");
		}
		String url5="https://vod.changxianggu.com/8361515043484582843738c518330f23/f6c131b81f584ca78ea755286eb38bb9-a10551b22e0202869f52c8cbe86f84c7-hd-%s.ts";
		for (int i = 1; i < 571; i++) {
			String format = String.format("%05d",i);
			String url  = String.format(url5, format);
//			httpDownload(url, "E:\\vedio5\\"+format+".ts");
		}
		String url6="https://vod.changxianggu.com/2efd3f8db2b943b7b7256ecfd4626634/4226d4a8fdea4e60a3d2de0cdc36866c-c4f7f59565017d50e7fff80d09924661-hd-%s.ts";
		for (int i = 1; i < 659; i++) {
			String format = String.format("%05d",i);
			String url = String.format(url6, format);
//			httpDownload(url, "E:\\vedio6\\"+format+".ts");
		}
		String url7="https://vod.changxianggu.com/87187023c8154a7fbd3bb8bd09a25c7e/eb22c8f75c154ea290e6702bbeb9ccb4-9d716ebecb9609f10f7e94a8d814486d-hd-%s.ts";
		for (int i = 1; i <669; i++) {
			String format = String.format("%05d",i);
			String url = String.format(url7, format);
//			httpDownload(url, "E:\\vedio7\\"+format+".ts");
		}
		String url8="https://vod.changxianggu.com/ca83c72299014837ac0744c8ea128ccd/bb4a7d89444f4ca2840e778c8f7c9a2a-c55bb49deb51830fd478b9617d915aee-hd-%s.ts";
		for (int i = 1; i < 621; i++) {
			String format = String.format("%05d",i);
			String url = String.format(url8, format);
//			httpDownload(url, "E:\\vedio8\\"+format+".ts");
		}
		String url9="https://vod.changxianggu.com/a0460542472748aaab5038104a39da59/18373eb4359c483f80ab309f5915e416-d41319408b6ee7adeff403943dd4e735-hd-%s.ts";
		for (int i = 1; i < 630; i++) {
			String format = String.format("%05d",i);
			String url = String.format(url9, format);
//			httpDownload(url, "E:\\vedio9\\"+format+".ts");
		}
		String url10="https://vod.changxianggu.com/0ccb607c3ee443c7bd6399ebe012860b/ddbebe5c6a94484891dcf4d298ff3e64-75e0baadb790ab3e211ad915351de680-hd-%s.ts";
		for (int i = 1; i < 357; i++) {
			String format = String.format("%05d",i);
			String url = String.format(url10, format);
//			httpDownload(url, "E:\\vedio10\\"+format+".ts");
		}
		
		
		
		
		
	}

	public static boolean httpDownload(String httpUrl, String saveFile) {
		// 1.下载网络文件
		int byteRead;
		URL url;
		try {
			url = new URL(httpUrl);
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
			return false;
		}

		try {
			//2.获取链接
			URLConnection conn = url.openConnection();
			//3.输入流
			InputStream inStream = conn.getInputStream();
			//3.写入文件
			FileOutputStream fs = new FileOutputStream(saveFile);

			byte[] buffer = new byte[1024];
			while ((byteRead = inStream.read(buffer)) != -1) {
				fs.write(buffer, 0, byteRead);
			}
			inStream.close();
			fs.close();
			return true;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}

}
