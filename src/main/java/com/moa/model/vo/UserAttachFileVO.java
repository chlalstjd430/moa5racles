package com.moa.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class UserAttachFileVO extends AttachFileVO {
    public UserAttachFileVO(String uuid, Long id, String uploadPath, String fileName, boolean fileType) {
        super(uuid, id, uploadPath, fileName, fileType);
    }

}