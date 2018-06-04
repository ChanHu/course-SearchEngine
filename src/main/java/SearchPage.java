package servlet;

import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.wltea.analyzer.lucene.IKAnalyzer;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Created by MoSon on 2017/7/1.
 */
public class SearchPage {
    public ScoreDoc[] SearchTerm(String TermKey){
        //定义索引目录
//        Path path = FileSystems.getDefault().getPath("index");
        Path path= Paths.get("d:\\LueneIndex");
        Directory directory = null;
        try {
            directory = FSDirectory.open(path);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //定义索引查看器
        IndexReader indexReader = null;
        try {
            indexReader = DirectoryReader.open(directory);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //定义搜索器
        IndexSearcher indexSearcher = new IndexSearcher(indexReader);
        //搜索内容


        //搜索关键字
        String  keyWords = TermKey;

        //分页信息
        Integer page = 1;
        Integer pageSize = 20;
        Integer start = (page-1) * pageSize;
        Integer end = start + pageSize;

        Query query = null;//模糊搜索
        try {
            query = new QueryParser("name",new IKAnalyzer()).parse(keyWords);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        //命中前10条文档
        TopDocs topDocs = null;//根据end查询
        try {
            topDocs = indexSearcher.search(query,end);
        } catch (IOException e) {
            e.printStackTrace();
        }

        Integer totalPage = ((topDocs.totalHits/ pageSize) ==0)
                ? topDocs.totalHits/pageSize
                : ((topDocs.totalHits / pageSize) +1);

        System.out.println("“"+ keyWords +"”搜索到"+ topDocs.totalHits
                + "条数据，页数："+ page +"/"+ totalPage);
        //打印命中数
        System.out.println("命中数："+topDocs.totalHits);
        //取出文档
        ScoreDoc[] scoreDocs = topDocs.scoreDocs;
        int length = scoreDocs.length> end ? end : scoreDocs.length;
        //遍历取出数据
        for (int i = start;i < length;i++){
            ScoreDoc doc = scoreDocs[i];
            System.out.println("得分："+ doc.score);
            Document document = null;
            try {
                document = indexSearcher.doc(doc.doc);
            } catch (IOException e) {
                e.printStackTrace();
            }
            System.out.println("ID:"+ document.get("id"));
            System.out.println("name:"+document.get("name"));
            System.out.println("Score:"+document.get("score"));
            System.out.println("school:"+document.get("school"));
            System.out.println("Eval:"+document.get("Eval"));
            System.out.println("EvalAmount:"+document.get("EvalAmount"));
            System.out.println("AttendAmount:"+document.get("AttendAmount"));
            System.out.println("-----------------------");
        }

        //关闭索引查看器
        try {
            indexReader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return scoreDocs;
    }
    public static void main(String[] args)throws IOException,ParseException {
        SearchPage searchPage=new SearchPage();
        searchPage.SearchTerm("C语言");
    }
}