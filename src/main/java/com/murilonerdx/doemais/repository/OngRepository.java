package com.murilonerdx.doemais.repository;

import com.murilonerdx.doemais.entities.Ong;
import com.murilonerdx.doemais.entities.Userman;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OngRepository extends JpaRepository<Ong, Long> {
    Ong findByUser(Userman user);
}