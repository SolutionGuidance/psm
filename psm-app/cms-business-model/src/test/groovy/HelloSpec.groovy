import spock.lang.Specification
import spock.lang.Unroll

@Unroll
class HelloSpec extends Specification {
    void "tests run properly (#a == #b)"(int a, int b) {
        expect:
        a == b

        where:
        a | b
        1 | 1
        2 | 2
        3 | 3
    }
}
