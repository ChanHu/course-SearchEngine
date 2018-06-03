import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;


import java.io.File;
import java.io.IOException;
import java.util.BitSet;

public class IndexSearch {
    public void indexSearch(String keys) throws Exception{
        // 创建query对象
        // 使用QueryParser搜索时，需要指定分词器，搜索时的分词器要和索引时的分词器一致
        // 第一个参数：默认搜索的域的名称
        QueryParser parser = new QueryParser("description",new StandardAnalyzer());
        // 通过queryparser来创建query对象
        // 参数：输入的lucene的查询语句(关键字一定要大写)
        Query query = parser.parse(keys);

        // 指定索引库的地址
        File indexFile = new File("D:/LueneIndex/index");
        Directory directory = FSDirectory.getDirectory(indexFile,false);
//        IndexReader reader = IndexReader.open(directory);
        // 创建IndexSearcher
        IndexSearcher searcher = new IndexSearcher(directory);
//        IndexSearcher searcher = new IndexSearcher(reader);
        // 通过searcher来搜索索引库
        // 第二个参数：
        if(!indexFile.exists()){
            System.out.println("The Lucene index is not exist");
            return;
        }
        Hits hh=searcher.search(query);
        Filter filter = new Filter() {
            @Override
            public BitSet bits(IndexReader indexReader) throws IOException {
                return null;
            }
        };
        TopDocs topDocs = searcher.search(query,filter,10);
        // 根据查询条件匹配出的记录总数
        int count = topDocs.totalHits;
        System.out.println("匹配出的记录总数:" + count);
        // 根据查询条件匹配出的记录
        ScoreDoc[] scoreDocs = topDocs.scoreDocs;
//        Document ss=searcher.doc(1);
//        System.out.println("seacher's docs :"+ss.getField("name")+"num"+searcher.search(query).length());
        for (ScoreDoc scoreDoc : scoreDocs) {
            // 获取文档的ID
            int docId = scoreDoc.doc;
            // 通过ID获取文档
            Document doc = searcher.doc(docId);
            System.out.println("商品ID：" + doc.get("id"));
            System.out.println("商品名称：" + doc.get("name"));
            System.out.println("商品价格：" + doc.get("price"));
            // System.out.println("商品描述：" + doc.get("description"));
            System.out.println("==========================");
        }
        // 关闭资源
//        reader.close();
    }
}
