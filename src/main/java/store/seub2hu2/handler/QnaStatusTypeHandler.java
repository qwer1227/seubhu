package store.seub2hu2.handler;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import store.seub2hu2.mypage.enums.QnaStatus;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class QnaStatusTypeHandler extends BaseTypeHandler<QnaStatus> {
    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, QnaStatus parameter, JdbcType jdbcType) throws SQLException {
        ps.setInt(i, parameter.getCode());  // Enum을 숫자 값으로 설정
    }

    @Override
    public QnaStatus getNullableResult(ResultSet rs, String columnName) throws SQLException {
        int code = rs.getInt(columnName);
        return QnaStatus.fromCode(code);  // 숫자 값을 Enum으로 변환
    }

    @Override
    public QnaStatus getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        int code = rs.getInt(columnIndex);
        return QnaStatus.fromCode(code);  // 숫자 값을 Enum으로 변환
    }

    @Override
    public QnaStatus getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        int code = cs.getInt(columnIndex);
        return QnaStatus.fromCode(code);  // 숫자 값을 Enum으로 변환
    }
}
