select dimension,0.7213/(1 + 1.079/4096) * pow(4096,2) * 1/sum(pow(2,-1*first_non_zero)) cardinality_estimate
from (
  select 
    register_number, 
    dimension,
    max(first_non_zero) as first_non_zero
  from (
    select
      register_number,
      dimension,
      length(nvl(regexp_substr(sha1_binary,'^0*'),''))+1 as first_non_zero
    from (
      select
        element,
        dimension,
        register_number,
        ((sha1>>0)%2)::varchar+((sha1>>1)%2)::varchar+((sha1>>2)%2)::varchar+((sha1>>3)%2)::varchar+
        ((sha1>>4)%2)::varchar+((sha1>>5)%2)::varchar+((sha1>>6)%2)::varchar+((sha1>>7)%2)::varchar+
        ((sha1>>8)%2)::varchar+((sha1>>9)%2)::varchar+((sha1>>10)%2)::varchar+((sha1>>11)%2)::varchar+
        ((sha1>>12)%2)::varchar+((sha1>>13)%2)::varchar+((sha1>>14)%2)::varchar+((sha1>>15)%2)::varchar+
        ((sha1>>16)%2)::varchar+((sha1>>17)%2)::varchar+((sha1>>18)%2)::varchar+((sha1>>19)%2)::varchar+
        ((sha1>>20)%2)::varchar+((sha1>>21)%2)::varchar+((sha1>>22)%2)::varchar+((sha1>>23)%2)::varchar+
        ((sha1>>24)%2)::varchar+((sha1>>25)%2)::varchar+((sha1>>26)%2)::varchar+((sha1>>27)%2)::varchar+
        ((sha1>>28)%2)::varchar+((sha1>>29)%2)::varchar+((sha1>>30)%2)::varchar+((sha1>>31)%2)::varchar+
        ((sha1>>32)%2)::varchar+((sha1>>33)%2)::varchar+((sha1>>34)%2)::varchar+((sha1>>35)%2)::varchar+
        ((sha1>>36)%2)::varchar+((sha1>>37)%2)::varchar+((sha1>>38)%2)::varchar+((sha1>>39)%2)::varchar+
        ((sha1>>40)%2)::varchar+((sha1>>41)%2)::varchar+((sha1>>42)%2)::varchar+((sha1>>43)%2)::varchar+
        ((sha1>>44)%2)::varchar+((sha1>>45)%2)::varchar+((sha1>>46)%2)::varchar+((sha1>>47)%2)::varchar+
        ((sha1>>48)%2)::varchar+((sha1>>49)%2)::varchar+((sha1>>50)%2)::varchar+((sha1>>51)%2)::varchar+
        ((sha1>>52)%2)::varchar+((sha1>>53)%2)::varchar+((sha1>>54)%2)::varchar+((sha1>>55)%2)::varchar as sha1_binary
      from (
        select
          element,
          dimension,
          func_sha1(element) as sha1_hash,
          strtol(left(func_sha1(element),3),16) register_number,
          strtol(right(func_sha1(element),14),16) as sha1
        from (
          select date(created_at) as dimension, product_id as element
          from sales
        )
      )    
    )
  )
  group by register_number, dimension
)
group by dimension