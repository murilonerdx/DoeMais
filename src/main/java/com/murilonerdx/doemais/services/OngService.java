package com.murilonerdx.doemais.services;

import com.murilonerdx.doemais.dto.OngDTO;
import com.murilonerdx.doemais.entities.Ong;
import com.murilonerdx.doemais.entities.Permission;
import com.murilonerdx.doemais.exceptions.DataIntegretyException;
import com.murilonerdx.doemais.exceptions.ResourceNotFoundException;
import com.murilonerdx.doemais.repository.OngRepository;
import com.murilonerdx.doemais.util.DozerConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OngService {

    @Autowired
    private OngRepository repository;

    public List<OngDTO> findAll() {
        return DozerConverter.parseListObjects(repository.findAll(), OngDTO.class);
    }

    public void delete(Long id) {
        Ong entity = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("No records found for this ID"));
        repository.delete(entity);
    }

    public OngDTO create(OngDTO ongDTO) {
        try {
            String password = ongDTO.getUser().getPassword();
            ongDTO.getUser().setPassword(new BCryptPasswordEncoder().encode(password));

            Ong ong = DozerConverter.parseObject(ongDTO, Ong.class);
            ong.setId(null);
            ong.getUser().getPermissions().add(new Permission(null, "ROLE_ONG"));

            return DozerConverter.parseObject(repository.save(ong), OngDTO.class);
        } catch (DataIntegrityViolationException e) {
            throw new DataIntegretyException("Username já existe");
        }

    }
}