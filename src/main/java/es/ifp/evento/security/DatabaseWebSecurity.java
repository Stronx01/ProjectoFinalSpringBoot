package es.ifp.evento.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
public class DatabaseWebSecurity extends WebSecurityConfigurerAdapter {
    @Autowired
    private DataSource dataSource;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception
    {
        auth.jdbcAuthentication().dataSource(dataSource)
                .usersByUsernameQuery("select username,password,enabled from "+
                        "Usuarios where username=?")
                .authoritiesByUsernameQuery("select u.username, p.nombre from "+
                        "Usuario_Perfiles up inner join Usuarios u on u.username" +
                        " = up.username inner join Perfiles p on p.id_perfil = up.id_Perfil " +
                                "where u.username = ?");
    }
    @Override
    protected void configure(HttpSecurity http) throws Exception{
        http.csrf().disable().authorizeRequests();
        //RecursosEstaticos
        http.authorizeRequests().antMatchers("bootstrap/**",
                "img/**","CSS/**","node_modules/**").permitAll()
                //URL
                .antMatchers("/index/**").permitAll()
                .antMatchers("/**").permitAll()
                //AUTORIZACION
                .antMatchers("/cliente/**").hasAnyAuthority("CLIENTE")
                //LOGIN
                .anyRequest().authenticated().and().formLogin().permitAll();
    }
}

