import './App.css';
import React, { useEffect, useState, useRef } from 'react';
import axios from 'axios';
import 'bootstrap'
import Modal from 'react-modal'
Modal.setAppElement('#root');


function App() {

  const [getProductos, setProductos] = useState([]);
  const [getCategorias, setCategorias] = useState([]);
  const [getEstantes, setEstantes] = useState([]);
  const [getModalCrear, setModalCrear] = useState(null);
  const [getModalEditar, setModalEditar] = useState(null);
  const [getEditarProd, setEditarProd] = useState(null);


  const nombreRef = useRef(null)
  const precioRef = useRef(null)
  const categoriaRef = useRef(null)
  const cantidadRef = useRef(null)
  const estanteRef = useRef(null)
  const refDescri = useRef(null)

  useEffect(() => {
    querySuprema();

   /*  setTimeout(function(){
      queryProductos();
      }, 2000); */
  }, []);

  const querySuprema = async () => {
    try {
      const response = await axios.get('http://localhost:3000/producto'); 
      setProductos(response.data);
    } catch (error) {
      console.error(error);
    }

    try {
      const response = await axios.get('http://localhost:3000/categorias'); 
      setCategorias(response.data);
      /* console.log(getCategorias) */
    } catch (error) {
      console.error(error);
    }

    try {
      const response = await axios.get('http://localhost:3000/estantes'); 
      setEstantes(response.data);
      /* console.log(getEstantes) */
    } catch (error) {
      console.error(error);
    }
  };

  const eliminar =  (id) => {
    axios.delete('http://localhost:3000/producto', {
      data: { id: id }
    })
      .then(response => {
        // Manejar la respuesta exitosa
        console.log('Elemento eliminado');
      })
      .catch(error => {
        // Manejar el error
        console.error('Error al eliminar el elemento', error);
      });
  };

  const editar =  async (idProducto) => {
      await axios.put ('http://localhost:3000/producto', {
        id: idProducto,
        nombre: nombreRef.current.value,
        descripcion: refDescri.current.value,
        cantidad: parseInt(cantidadRef.current.value),
        precio: parseInt(precioRef.current.value)
    })

      
    setModalEditar(null)
    setEditarProd(null)
      window.location.reload();
  };

  const agregarProducto =   async () => {
    console.log(nombreRef.current.value)
    console.log(estanteRef.current.value)
    await axios.post('http://localhost:3000/producto', {
        nombre: nombreRef.current.value,
        descripcion: refDescri.current.value,
        cantidad: parseInt(cantidadRef.current.value),
        precio: parseInt(precioRef.current.value),
        id_estante: parseInt(estanteRef.current.value),
        id_categoria: parseInt(categoriaRef.current.value)
      })

        
        setModalCrear(false)
        window.location.reload();
    

  };

  const editing = (producto) => {
    console.log(producto)
     setModalEditar(true);
     setEditarProd(producto)

  };


/*   nombre: nombreRef.current.value,
  descripcion: refDescri.current.value,
  cantidad: cantidadRef.current.value,
  precio: precioRef.current.value,
  id_estante: estanteRef.current.value,
  id_categoria: categoriaRef.current.value */



  return (
    <div className="App">
        <div>
        <div className="had ful">CRUD DISTRIBUIDORA - Grupo 6</div>

        <div className="ful distb">
          <div className="txt-cnt tabs home unslct">Productos </div>
          
        </div>

        <div className="ful tab-wrp">
          <div className="wrp-main ful">
            <form>
              

            <div className="ful task ">
                  <div className="time right txt-cnt red">CANTIDAD</div>
                  <div className="time  right txt-cnt red">PRESIO</div>
                  <div className="time  right txt-cnt red">ESTANTE</div>
                  <div className="time  right txt-cnt red"> CATEGORIA</div>
                  <div className="time  right txt-cnt "><button  type="button" style={{ backgroundColor: 'green', color: 'white' , borderRadius:'10px', padding:'10px', border: 'none'}} onClick={() => setModalCrear(true)}>AGREGAR</button></div>
                  <label htmlFor="task1" style={{'margin-left':'20px'}}> NOMBRE</label>
              </div>

 
            {getProductos.productos?.map((producto) => (
              
                    <div key={producto.id}>
                        {/* {console.log(producto)} */}
                <div className="ful task ">
                  <div className="time right txt-cnt ">{producto.cantidad}</div>
                  <div className="time  right txt-cnt">{producto.precio}</div>
                  <div className="time  right txt-cnt ">{producto.id_estante}</div>
                  <div className="time  right txt-cnt "> {producto.id_categoria}</div>
                  <div className="time  right txt-cnt btn"><button  style={{ backgroundColor: 'red', color: 'white',  borderRadius:'10px', padding:'10px', border: 'none'  }} onClick={() => eliminar(producto.id)}>ELIMINAR</button></div>
                  <div className="time  right txt-cnt "><button type="button"  style={{ backgroundColor: 'blue', color: 'white' , borderRadius:'10px', padding:'10px', border: 'none'}} onClick={() => editing(producto)}>EDITAR</button></div>
                  <label htmlFor="task1" style={{'margin-left':'20px'}}>  {producto.nombre} </label>
                </div>
                 </div>
                  ))}
 
            </form>
          </div>
        </div>
      </div>

            

      <Modal
            isOpen={getModalCrear !== null} 
            onRequestClose={() => setModalCrear(null)}
            ariaHideApp={false}
            style={{
              overlay: {
                  zIndex:1000,
                  display:'flex',
                  justifyContent:'center',
                  alignItems:'center',
                  backgroundColor: 'rgba(0, 0, 0, 0.50)',
                  padding:0,
                  right:0
              },
              content: {
                  maxHeight:'59%',
                  overflow:'auto'
              }
          }}
          >



               <div className='input' style={{gridColumn:'2', gridRow:'1'}}>
                          <p className='nombre-inputs'><b>Nombre</b></p>
                          <input type="text" ref={nombreRef} defaultValue={""} placeholder="Nombre Producto"/>
                </div>

                <div className='input' style={{gridColumn:'2', gridRow:'1'}}>
                          <p className='nombre-inputs'><b>Precio</b></p>
                          <input type="text" ref={precioRef} defaultValue={""} placeholder="Precio Producto"/>
                </div>

                <div className='input' style={{gridColumn:'2', gridRow:'1'}}>
                          <p className='nombre-inputs'><b>Descripcion</b></p>
                          <input type="text" ref={refDescri} defaultValue={""} placeholder="Descripcion Producto"/>
                </div>

                <div className='input' style={{gridColumn:'2', gridRow:'1'}}>
                          <p className='nombre-inputs'><b>Cantidad</b></p>
                          <input type="text" ref={cantidadRef} defaultValue={""} placeholder="Cantidad Producto"/>
                </div>

                <div className='input' style={{gridColumn:'2', gridRow:'1'}}>
                          <p className='nombre-inputs'><b>Categoria</b></p>
                          {
                                getCategorias.categorias != null &&
                                <select ref={categoriaRef}>
                                    {
                                        getCategorias.categorias.map((value, index) => {
                                            return (<option style={{fontSize:18}} key={index} value={value.id}>{value.nombre}</option>)
                                        })
                                    }
                                </select>
                            }
                </div>


                <div className='input' style={{gridColumn:'2', gridRow:'1'}}>
                          <p className='nombre-inputs'><b>Estante</b></p>
                          {
                                getEstantes.estantes != null &&
                                <select ref={estanteRef}>
                                    {
                                        getEstantes.estantes.map((value, index) => {
                                            return (<option style={{fontSize:18}} key={index} value={value.id}>{value.nombre}</option>)
                                        })
                                    }
                                </select>
                            }
                </div>

   
                <button style={{width:'100%', background:'green', fontSize:'1rem', color:'white', border:'none', padding:'10px', borderRadius:'10px'}} onClick={() => agregarProducto() }>Agregar Producto</button>
            </Modal>


            <Modal
            isOpen={getModalEditar !== null} 
            onRequestClose={() => setModalEditar(null)}
            ariaHideApp={false}
            style={{
              overlay: {
                  zIndex:1000,
                  display:'flex',
                  justifyContent:'center',
                  alignItems:'center',
                  backgroundColor: 'rgba(0, 0, 0, 0.50)',
                  padding:0,
                  right:0
              },
              content: {
                  maxHeight:'45%',
                  overflow:'auto'
              }
          }}
          >
              {getEditarProd != null &&


                <div>
                  
                          <div className='input' style={{gridColumn:'2', gridRow:'1'}}>
                          <p className='nombre-inputs'><b>Nombre</b></p>
                          <input type="text" ref={nombreRef} value={getEditarProd.nombre} placeholder="Nombre Producto" onChange={(e) => setEditarProd(i => { return {...i, nombre: e.target.value} })}/>
                </div>

                      <div className='input' style={{gridColumn:'2', gridRow:'1'}}>
                                <p className='nombre-inputs'><b>Precio</b></p>
                                <input type="text" ref={precioRef} value={getEditarProd.precio} placeholder="Precio Producto" onChange={(e) => setEditarProd(i => { return {...i, precio: e.target.value} })}/>
                      </div>

                      <div className='input' style={{gridColumn:'2', gridRow:'1'}}>
                                <p className='nombre-inputs'><b>Descripcion</b></p>
                                <input type="text" ref={refDescri} value={getEditarProd.descripcion} placeholder="Descripcion Producto" onChange={(e) => setEditarProd(i => { return {...i, descripcion: e.target.value} })}/>
                      </div>

                      <div className='input' style={{gridColumn:'2', gridRow:'1'}}>
                                <p className='nombre-inputs'><b>Cantidad</b></p>
                                <input type="text" ref={cantidadRef} value={getEditarProd.cantidad} placeholder="Cantidad Producto" onChange={(e) => setEditarProd(i => { return {...i, cantidad: e.target.value} })}/>
                      </div>

                </div>
                }
   
                <button style={{width:'100%', background:'green', fontSize:'1rem', color:'white', border:'none', padding:'10px', borderRadius:'10px'}} onClick={() => editar(getEditarProd.id) }>EDITAR</button>
            </Modal>











            

        </div>
  );
}

export default App;
