package com.xiangyun.notary.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class FreeMakerTest {

	private Configuration configuration = null;

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		FreeMakerTest tester = new FreeMakerTest();
		// TODO Auto-generated method stub
		tester.configuration = new Configuration();
		tester.configuration.setDefaultEncoding("utf-8");

		// 要填入模本的数据文件
		Map dataMap = new HashMap();
		tester.getData(dataMap);
		// 设置模本装置方法和路径,FreeMarker支持多种模板装载方法。可以重servlet，classpath，数据库装载，
		// 这里我们的模板是放在com.havenliu.document.template包下面
		tester.configuration.setClassForTemplateLoading(tester.getClass(),
				"/");
		Template t = null;
		try {
			// test.ftl为要装载的模板
			t = tester.configuration.getTemplate("template.ftl");
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 输出文档路径及名称
		File outFile = new File("C:/temp/outFile.doc");
		Writer out = null;
		try {
			out = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(outFile)));
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}

		try {
			t.process(dataMap, out);
		} catch (TemplateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 注意dataMap里存放的数据Key值要与模板中的参数相对应
	 * 
	 * @param dataMap
	 */
	private void getData(Map dataMap) {
		dataMap.put("customer_name", "徐晋");
		dataMap.put("customer_sex", "男");
		dataMap.put("customer_birth_date", "1980-08-09");
		dataMap.put("customer_address", "上海市成山路2008弄50号1802室");
		dataMap.put("customer_id", "310102198008090010");
		dataMap.put("order_content", "出生");
		dataMap.put("order_country", "美国");
		dataMap.put("order_lang", "英语");
		dataMap.put("order_copy_num", "3");
		dataMap.put("order_need_cert", "是");
		dataMap.put("order_reason", "学习");
		
	}

}
