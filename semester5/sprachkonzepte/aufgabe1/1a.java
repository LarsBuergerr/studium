import java.util.regex.Matcher;
import java.util.regex.Pattern;


class one_a{
    public static void main(String args[]) {


        Pattern generalPattern = Pattern.compile("(%([<\\d]\\$)?[-+#0,(s]?\\d?(\\.\\d)?([bBhHsScCdoxXeEfgGaA%n]|[tT][HIklMSLNpzZsQBbhAaCYyjmdeRTrDFc]))");

        String blabla = "%dblabla";

        String bla2   = "djfdkaf;dasj%d";

        Matcher matcher = generalPattern.matcher(blabla);
        Matcher matcher2 = generalPattern.matcher(bla2);

        matcher.find();
        matcher2.find();

        System.out.printf("%s", matcher2.group());

        System.out.printf("%s", matcher.group());

    }
}