-- Activarea schemei în ORDS
BEGIN
  ORDS.ENABLE_SCHEMA(
    p_enabled             => TRUE,
    p_schema              => 'SYSTEM',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'music',
    p_auto_rest_auth      => FALSE
  );
  COMMIT;
END;
/
-- Publicarea view-ului V_MONGO
BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'SYSTEM',
    p_object         => 'V_MONGO',
    p_object_type    => 'VIEW',
    p_object_alias   => 'mongo-rankings',
    p_auto_rest_auth => FALSE
  );
  COMMIT;
END;
/
-- Publicarea view-ului V_MUSIC_INTEGRATION
BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'SYSTEM',
    p_object         => 'V_MUSIC_INTEGRATION',
    p_object_type    => 'VIEW',
    p_object_alias   => 'music-integration',
    p_auto_rest_auth => FALSE
  );
  COMMIT;
END;
/
-- Publicarea view-ului FACT_MUSIC
BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'SYSTEM',
    p_object         => 'FACT_MUSIC',
    p_object_type    => 'VIEW',
    p_object_alias   => 'fact-music',
    p_auto_rest_auth => FALSE
  );
  COMMIT;
END;
/
-- Publicarea view-ului OLAP_STREAMS_BY_REGION
BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'SYSTEM',
    p_object         => 'OLAP_STREAMS_BY_REGION',
    p_object_type    => 'VIEW',
    p_object_alias   => 'streams-by-region',
    p_auto_rest_auth => FALSE
  );
  COMMIT;
END;
/
-- Publicarea view-ului OLAP_RANK_ANALYSIS
BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'SYSTEM',
    p_object         => 'OLAP_RANK_ANALYSIS',
    p_object_type    => 'VIEW',
    p_object_alias   => 'rank-analysis',
    p_auto_rest_auth => FALSE
  );
  COMMIT;
END;
/
