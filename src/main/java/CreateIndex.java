

import Dao.CourseEntity;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.wltea.analyzer.lucene.IKAnalyzer;
import servlet.QueryCouseList;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import static org.apache.lucene.document.TextField.TYPE_STORED;


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

                Field school = new Field("school","null",TYPE_STORED);

            if(course.getCouSchool()!=null) {
                school = new Field("school", course.getCouSchool(), TYPE_STORED);
            }

            Field Score = new Field("score",course.getCouScore().toString(),TYPE_STORED);

            document.add(id);
            document.add(name);
            document.add(school);
            document.add(Eval);
            document.add(EvalAmount);
            document.add(AttendAmount);
            document.add(Score);
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