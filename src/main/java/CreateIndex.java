//import Dao.CourseEntity;
//import org.apache.lucene.analysis.Analyzer;
//import org.apache.lucene.analysis.standard.StandardAnalyzer;
//import org.apache.lucene.document.Document;
//import org.apache.lucene.document.Field;
//import org.apache.lucene.index.IndexWriter;
//import org.apache.lucene.store.Directory;
//import org.apache.lucene.store.FSDirectory;
//
//
//import java.io.File;
//import java.util.ArrayList;
//import java.util.List;
//
//public class CreatIndexWriter {
//    public static void main( String[] args) throws Exception {
//        List<CourseEntity> courses=new QueryCouseList().queryCourseList();
//        List<Document> doclist=new ArrayList<Document>();
//        Document document;
//        for(CourseEntity course: courses){
//            document=new Document();
//            Field id = new Field("id",course.getCouId().toString(),true,true,true);
//            Field name =  new Field("name",course.getCouName(),true,true,true);
//            Field Eval = new Field("Eval",course.getCouEval().toString(),true,true,true);
//            Field EvalAmount = new Field("EvalAmount",course.getCouEvalAmount().toString(),true,true,true);
//            Field AttendAmount = new Field("AttendAmount",course.getCouAttendAmount().toString(),true,true,true);
//            Field school = new Field("school",course.getCouName(),true,true,true);
//
//            document.add(id);
//            document.add(name);
//            document.add(school);
//            document.add(Eval);
//            document.add(EvalAmount);
//            document.add(AttendAmount);
//            doclist.add(document);
//        }
//        Analyzer analyzer= new StandardAnalyzer();
//
//        File indexFile = new File("D:/LueneIndex/index");
//        Directory directory = FSDirectory.getDirectory(indexFile, true);
//        IndexWriter writer = new IndexWriter(directory, analyzer,true);
//
//
//        for(Document doc: doclist) {
//            writer.addDocument(doc);
//        }
//    }
//
//
//}
import Dao.CourseEntity;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.LegacyLongField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.wltea.analyzer.lucene.IKAnalyzer;

import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import static org.apache.lucene.document.TextField.TYPE_STORED;

/**
 * Created by MoSon on 2017/6/30.
 */
public class CreateIndex {

    public static void main(String[] args) throws Exception {
        //定义IndexWriter
        //index是一个相对路径，当前工程
//        Path path = FileSystems.getDefault().getPath("", "index");
        Path path= Paths.get("d:\\LueneIndex");
        Directory directory = FSDirectory.open(path);
        //定义分词器
//        Analyzer analyzer = new StandardAnalyzer();
        Analyzer analyzer = new IKAnalyzer();
        IndexWriterConfig indexWriterConfig = new IndexWriterConfig(analyzer).setOpenMode(IndexWriterConfig.OpenMode.CREATE);
        IndexWriter indexWriter = new IndexWriter(directory, indexWriterConfig);

        //定义文档
        ;
        List<CourseEntity> courses=new QueryCouseList().queryCourseList();
        List<Document> doclist=new ArrayList<Document>();
        Document document;
        for(CourseEntity course: courses){
            document=new Document();
            //定义文档字段
            Field id = new Field("id",course.getCouId(),TYPE_STORED);
            Field name =  new Field("name",course.getCouName(),TYPE_STORED);
            Field Eval = new Field("Eval",course.getCouEval().toString(),TYPE_STORED);
            Field EvalAmount = new Field("EvalAmount",course.getCouEvalAmount().toString(),TYPE_STORED);
            Field AttendAmount = new Field("AttendAmount",course.getCouAttendAmount().toString(),TYPE_STORED);
            Field school = new Field("school",course.getCouName(),TYPE_STORED);

            document.add(id);
            document.add(name);
            document.add(school);
            document.add(Eval);
            document.add(EvalAmount);
            document.add(AttendAmount);
            doclist.add(document);
        }

        //写入数据
        for(Document document1:doclist){
            indexWriter.addDocument(document1);
        }

        //提交
        indexWriter.commit();
        //关闭
        indexWriter.close();

    }


}